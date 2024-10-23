import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:placeholder/services/model.dart';

const String baseUrl =
    '{BACK_END_API}';

// 모든 지원 지역 조회
Future<List<HotPlace>> fetchHotPlaces(String guName) async {
  final uri = Uri.parse('${baseUrl}/hotplace/read/all?gu=$guName');
  print('Request URL: $uri');

  try {
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${utf8.decode(response.bodyBytes)}');

    if (response.statusCode == 200) {
      String jsonString = utf8.decode(response.bodyBytes);
      Iterable jsonResponse = json.decode(jsonString);
      return jsonResponse.map((place) => HotPlace.fromJson(place)).toList();
    } else {
      throw Exception(
          'Failed to load hot places: ${response.statusCode} ${response.reasonPhrase}, Response body: ${utf8.decode(response.bodyBytes)}');
    }
  } catch (error) {
    print('Error occurred: $error');
    rethrow;
  }
}

// gu -> parking
Future<List<ParkingLot>> parkingplaces(String gu) async {
  final response = await http.get(
    Uri.parse('$baseUrl/hotplace/read/parkinglot?gu=$gu'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    String jsonString = utf8.decode(response.bodyBytes);
    Iterable jsonResponse = json.decode(jsonString);
    return jsonResponse.map((place) => ParkingLot.fromJson(place)).toList();
  } else {
    throw Exception('Failed to load hot places: ${response.statusCode}');
  }
}

// 구별 음식점 조회
Future<List<CategoryPlaceDetail>> restaurantPlacesDetail(String guName) async {
  final response = await http.get(
    Uri.parse('${baseUrl}/hotplace/read/restaurant?gu=$guName'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    String jsonString = utf8.decode(response.bodyBytes);
    List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse
        .map((place) => CategoryPlaceDetail.fromJson(place))
        .toList();
  } else {
    throw Exception('Failed to load places');
  }
}

// 구별 카페 조회
Future<List<CategoryPlaceDetail>> cafePlacesDetail(String guName) async {
  final response = await http.get(
    Uri.parse('${baseUrl}/hotplace/read/cafe?gu=$guName'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    String jsonString = utf8.decode(response.bodyBytes);
    List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse
        .map((place) => CategoryPlaceDetail.fromJson(place))
        .toList();
  } else {
    throw Exception('Failed to load places');
  }
}

// 구별 놀거리 조회
Future<List<CategoryPlaceDetail>> enterPlacesDetail(String guName) async {
  final response = await http.get(
    Uri.parse('${baseUrl}/hotplace/read/enter?gu=$guName'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    String jsonString = utf8.decode(response.bodyBytes);
    List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse
        .map((place) => CategoryPlaceDetail.fromJson(place))
        .toList();
  } else {
    throw Exception('Failed to load places');
  }
}

// place 상세 조회
Future<CategoryPlaceDetail> fetchPlaceDetail(
    String partitionKey, String sortKey) async {
  final queryParameters = {
    'hotplacePartitionKey': partitionKey,
    'hotplaceSortKey': sortKey,
  };
  final uri = Uri.https('{BACK_END_API_V2}',
      '/placeholder/hotplace/read/detail', queryParameters);
  print('Request URL: $uri');

  try {
    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    final decodedResponseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      if (decodedResponseBody.isEmpty) {
        throw Exception('Response body is empty');
      }
      Map<String, dynamic> jsonResponse = jsonDecode(decodedResponseBody);
      print('Response JSON: $jsonResponse');
      return CategoryPlaceDetail.fromJson(jsonResponse);
    } else {
      throw Exception(
          'Failed to load place detail: ${response.statusCode} ${response.reasonPhrase}, Response body: $decodedResponseBody');
    }
  } catch (error) {
    print('Partition key: $partitionKey');
    print('Sort key: $sortKey');
    print('Error occurred: $error');
    rethrow;
  }
}

// Future<List<ChatBotPlace>> fetchPlaces(String areaCd, String placeType) async {
//   final response = await http.get(
//     Uri.parse('$baseUrl/hotplace/read/place/$placeType?areaCd=$areaCd'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//   );

//   if (response.statusCode == 200) {
//     String jsonString = utf8.decode(response.bodyBytes);
//     List<dynamic> jsonResponse = json.decode(jsonString);
//     return jsonResponse.map((place) => ChatBotPlace.fromJson(place)).toList();
//   } else {
//     throw Exception('Failed to load places');
//   }
// }

// Future<void> sendNonAutoPostRequest(NonAutoPostData postData) async {
//   var url = Uri.parse('$baseUrl/course/write/place/cart/manual');

//   Map<String, String> headers = {"Content-type": "application/json"};

//   http.Response response = await http.post(
//     url,
//     headers: headers,
//     body: jsonEncode(postData.toJson()),
//   );

//   if (response.statusCode == 200) {
//     print('Response data: ${response.body}');
//   } else {
//     print('Request failed with status: ${response.statusCode}.');
//   }
// }

// Future<void> deleteNonAutoPostRequest(NonAutoPostData postData) async {
//   var url = Uri.parse('$baseUrl/course/write/place/cart/delete/manual');

//   Map<String, String> headers = {"Content-type": "application/json"};

//   http.Response response = await http.post(
//     url,
//     headers: headers,
//     body: jsonEncode(postData.toJson()),
//   );

//   if (response.statusCode == 200) {
//     print('Response data: ${response.body}');
//   } else {
//     print('Request failed with status: ${response.statusCode}.');
//   }
// }

// Future<void> sendAutoPostRequest(AutoPostData postData) async {
//   var url = Uri.parse('$baseUrl/course/write/place/cart/auto');

//   Map<String, String> headers = {"Content-type": "application/json"};

//   http.Response response = await http.post(
//     url,
//     headers: headers,
//     body: jsonEncode(postData.toJson()),
//   );

//   if (response.statusCode == 200) {
//     print('Response data: ${response.body}');
//   } else {
//     print('Request failed with status: ${response.statusCode}.');
//   }
// }

// Future<void> deleteAutoPostRequest(AutoPostData postData) async {
//   var url = Uri.parse('$baseUrl/course/write/place/cart/delete/auto');

//   Map<String, String> headers = {"Content-type": "application/json"};

//   http.Response response = await http.post(
//     url,
//     headers: headers,
//     body: jsonEncode(postData.toJson()),
//   );

//   if (response.statusCode == 200) {
//     print('Response data: ${response.body}');
//   } else {
//     print('Request failed with status: ${response.statusCode}.');
//   }
// }

// Future<CourseData?> fetchCourseData(String userId) async {
//   final url = Uri.parse('$baseUrl/course/write/place/cart?userId=$userId');

//   final response = await http.get(url);

//   if (response.statusCode == 200) {
//     final Map<String, dynamic> json = jsonDecode(response.body);
//     return CourseData.fromJson(json);
//   } else {
//     print('Request failed with status: ${response.statusCode}.');
//     return null;
//   }
// }

/////////////////////////////////////////////////

// Future<List<CourseOneDetail>?> createCourseOne(CourseRequestOne request) async {
//   final url = Uri.parse('$baseUrl/course/write/create/course/one');

//   final response = await http.post(
//     url,
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(request.toJson()),
//   );

//   if (response.statusCode == 200) {
//     String jsonString = utf8.decode(response.bodyBytes);
//     final List<dynamic> jsonResponse = jsonDecode(jsonString);
//     return jsonResponse
//         .map((place) => CourseOneDetail.fromJson(place))
//         .toList();
//   } else {
//     print('Request failed with status: ${response.statusCode}.');
//     return null;
//   }
// }

/////////////////////////////////////////////////

/////////////////////////////////////////////////

// Future<CourseThreeResponse?> createCourseThree(
//     CourseRequestThree request) async {
//   final url = Uri.parse('$baseUrl/course/write/create/course/three');

//   final response = await http.post(
//     url,
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(request.toJson()),
//   );

//   if (response.statusCode == 200) {
//     String jsonString = utf8.decode(response.bodyBytes);
//     final Map<String, dynamic> jsonResponse = jsonDecode(jsonString);
//     print('Response JSON: $jsonResponse'); // 응답 내용을 로그로 출력
//     return CourseThreeResponse.fromJson(jsonResponse);
//   } else {
//     print('Request failed with status: ${response.statusCode}.');
//     return null;
//   }
// }

/////////////////////////////////////////////////

//

/////////////////////////////////////////////////

// Future<void> deleteCourseCart(String memberId) async {
//   final url = Uri.parse(
//       'http://192.168.0.13:31152/course/write/place/cart/delete?memberId=$memberId');
//   try {
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//     );

//     if (response.statusCode == 200) {
//       print('Request successful');
//     } else {
//       print('Request failed with status: ${response.statusCode}');
//     }
//   } catch (e, stacktrace) {
//     print('Exception: $e');
//     print('Stacktrace: $stacktrace');
//   }
// }

/////////////////////////////////////////////////

Future<Member> fetchMember(String memberId) async {
  final response = await http
      .get(Uri.parse('${baseUrl}/course/read/member?memberId=$memberId'));

  if (response.statusCode == 200) {
    return Member.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load member');
  }
}

// 유저의 모든 코스 상세조회
Future<List<List<UserCourse>>> fetchMemberCourseDetail(String memberId) async {
  final url = Uri.parse(
      '${baseUrl}/course/read/membercourse/detail?memberId=$memberId');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      String decodedBody = utf8.decode(response.bodyBytes);
      List<dynamic> data = json.decode(decodedBody);
      List<List<UserCourse>> places = data.map((list) {
        return (list as List).map((item) => UserCourse.fromJson(item)).toList();
      }).toList();
      return places;
    } else {
      throw Exception(
          'Failed to load member course detail. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error fetching member course detail: $error');
    throw Exception('Failed to load member course detail: $error');
  }
}

// 실시간 실행중인 코스 조회
Future<List<MemberCourse>> fetchRealTimeCourses(String memberId) async {
  try {
    final response = await http.get(Uri.parse(
        '${baseUrl}/course/read/membercourse/realtime?memberId=$memberId'));

    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      List<dynamic> jsonList = json.decode(responseBody);
      return jsonList.map((json) => MemberCourse.fromJson(json)).toList();
    } else {
      print(
          'Failed to load member courses with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load member courses');
    }
  } catch (e) {
    print('Error occurred: $e');
    throw Exception('Failed to load member courses: $e');
  }
}

// 코스 종료
Future<void> stopRealTimeCourse(String memberId) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/course/write/membercourse/pause?memberId=$memberId'),
    );

    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      print('Member course stopped successfully');
    } else {
      print(
          'Failed to stop member course with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to stop member course');
    }
  } catch (e) {
    print('Error occurred: $e');
    throw Exception('Failed to stop member course: $e');
  }
}

// 유저 시작 정보 업데이트
Future<MemberData?> fetchStartLocationUpData(
    String memberId, String address) async {
  final url = Uri.parse(
      '$baseUrl/course/write/member/location?memberId=$memberId&address=$address');

  final response = await http.post(url);

  if (response.statusCode == 200) {
    return MemberData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load location data');
  }
}

// 코스생성에 이용하는 함수
Future<List<List<ResultCourse>>> createCourse(Map<String, String> body) async {
  final url = Uri.parse('${baseUrl}/course/write/membercourse/write');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode(body),
  );
  print('Response Body: ${utf8.decode(response.bodyBytes)}');

  if (response.statusCode == 200) {
    List<dynamic> responseBody = json.decode(utf8.decode(response.bodyBytes));
    return responseBody.map((list) {
      return (list as List).map((item) => ResultCourse.fromJson(item)).toList();
    }).toList();
  } else {
    throw Exception('Failed to create course');
  }
}

// 코스 실행 및 저장 함수
Future<void> insertCourseRunAndSave(
    CourseRunAndSaveModel courserunandsave) async {
  final url = Uri.parse('${baseUrl}/course/write/membercourse/');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(courserunandsave.toJson()),
  );

  if (response.statusCode == 200) {
    print('Member course inserted successfully');
  } else {
    throw Exception('Failed to insert member course');
  }
}

// 카카오 길찾기 api
const String kakaoUrl =
    'https://apis-navi.kakaomobility.com/v1/waypoints/directions';
const String apiKey = '{KAKAO_API_KEY}';

Future<DirectionsResponse> getDirections(DirectionsRequest request) async {
  final response = await http.post(
    Uri.parse(kakaoUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'KakaoAK $apiKey',
    },
    body: jsonEncode(request.toJson()),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    return DirectionsResponse.fromJson(data);
  } else {
    throw Exception('Failed to fetch directions');
  }
}

// 사용자 정보 받기
Future<UserData?> fetchUserData(String memberId) async {
  final String url = '${baseUrl}/course/read/member?memberId=$memberId';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final String utf8Body = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> data = json.decode(utf8Body);
      return UserData.fromJson(data);
    } else {
      print('Failed to load user data');
      return null;
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}
