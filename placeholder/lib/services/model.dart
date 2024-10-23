// 모든 지원 지역 조회
class HotPlace {
  final String hotplacePartitionKey;
  final String hotplaceSortKey;
  final String name;
  final double mapx;
  final double mapy;
  final String congestion;
  final String kakaoname;

  HotPlace({
    required this.hotplacePartitionKey,
    required this.hotplaceSortKey,
    required this.name,
    required this.mapx,
    required this.mapy,
    required this.congestion,
    required this.kakaoname,
  });

  factory HotPlace.fromJson(Map<String, dynamic> json) {
    return HotPlace(
      hotplacePartitionKey: json['hotplacePartitionKey'],
      hotplaceSortKey: json['hotplaceSortKey'],
      name: json['name'],
      mapx: double.parse(json['mapx'].toString()),
      mapy: double.parse(json['mapy'].toString()),
      congestion: json['congestion'],
      kakaoname: json['kakaoname'],
    );
  }
}

class ParkingLot {
  final String hotplace_partition_key;
  final String curParking;
  final String capacity;
  final String hotplace_sort_key;
  final String address_name;
  final String mapx;
  final String name;
  final String mapy;

  ParkingLot({
    required this.hotplace_partition_key,
    required this.curParking,
    required this.capacity,
    required this.hotplace_sort_key,
    required this.address_name,
    required this.mapx,
    required this.name,
    required this.mapy,
  });

  factory ParkingLot.fromJson(Map<String, dynamic> json) {
    return ParkingLot(
      hotplace_partition_key: json['hotplace_partition_key'],
      curParking: json['curParking'],
      capacity: json['capacity'],
      hotplace_sort_key: json['hotplace_sort_key'],
      address_name: json['address_name'],
      mapx: json['mapx'],
      name: json['name'],
      mapy: json['mapy'],
    );
  }
}

// 구별 음식점, 카페, 놀거리, place 상세 조회
class CategoryPlaceDetail {
  final String hotplacePartitionKey;
  final String hotplaceSortKey;
  final String name;
  final String mapX;
  final String mapY;
  final String category;
  final String? address;
  final String? rating;
  final String? imageUrl;
  final String? placeUrl;
  final List<Menu>? menus;
  final List<Keyword>? keywords;

  CategoryPlaceDetail({
    required this.hotplacePartitionKey,
    required this.hotplaceSortKey,
    required this.name,
    required this.mapX,
    required this.mapY,
    required this.category,
    required this.address,
    required this.rating,
    required this.imageUrl,
    required this.placeUrl,
    required this.menus,
    required this.keywords,
  });

  factory CategoryPlaceDetail.fromJson(Map<String, dynamic> json) {
    var menusFromJson = json['menus'] as List;
    List<Menu> menuList =
        menusFromJson.map((menu) => Menu.fromJson(menu)).toList();

    var keywordsFromJson = json['keywords'] as List;
    List<Keyword> keywordList =
        keywordsFromJson.map((keyword) => Keyword.fromJson(keyword)).toList();

    return CategoryPlaceDetail(
      hotplacePartitionKey: json['hotplacePartitionKey'],
      hotplaceSortKey: json['hotplaceSortKey'],
      name: json['name'],
      mapX: json['mapX'],
      mapY: json['mapY'],
      category: json['category'],
      address: json['address'],
      rating: json['rating'],
      imageUrl: json['imageUrl'],
      placeUrl: json['placeUrl'],
      menus: menuList,
      keywords: keywordList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hotplacePartitionKey': hotplacePartitionKey,
      'hotplaceSortKey': hotplaceSortKey,
      'name': name,
      'mapX': mapX,
      'mapY': mapY,
      'category': category,
      'address': address,
      'rating': rating,
      'imageUrl': imageUrl,
      'placeUrl': placeUrl,
      'menus': menus?.map((menu) => menu.toJson()).toList(),
      'keywords': keywords?.map((keyword) => keyword.toJson()).toList(),
    };
  }
}

class Menu {
  final String? item;
  final String? price;

  Menu({
    required this.item,
    required this.price,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      item: json['item'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item': item,
      'price': price,
    };
  }
}

class Keyword {
  final int? count;
  final String? keyword;

  Keyword({
    required this.count,
    required this.keyword,
  });

  factory Keyword.fromJson(Map<String, dynamic> json) {
    return Keyword(
      count: json['count'],
      keyword: json['keyword'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'keyword': keyword,
    };
  }
}

// class PlaceDetail {
//   final String areaCd;
//   final String placeName;
//   final String addressName;
//   final String categoryGroupName;
//   final String placeUrl;
//   final String imageUrl;
//   final String x;
//   final String y;

//   PlaceDetail({
//     required this.areaCd,
//     required this.placeName,
//     required this.addressName,
//     required this.categoryGroupName,
//     required this.placeUrl,
//     required this.imageUrl,
//     required this.x,
//     required this.y,
//   });

// class ChatBotPlace {
//   final String placeId;
//   final String areaCd;
//   final String id;
//   final String place_name;
//   final String address_name;
//   final String category_group_name;
//   final String place_url;
//   final String image_url;
//   final String x;
//   final String y;

//   ChatBotPlace({
//     required this.placeId,
//     required this.areaCd,
//     required this.id,
//     required this.place_name,
//     required this.address_name,
//     required this.category_group_name,
//     required this.place_url,
//     required this.image_url,
//     required this.x,
//     required this.y,
//   });

///////////////////////////////////////////////////////////////////

// class CourseRequestOne {
//   final String address;
//   final String userEmail;

//   CourseRequestOne({required this.address, required this.userEmail});

//   Map<String, dynamic> toJson() {
//     return {
//       'address': address,
//       'userEmail': userEmail,
//     };
//   }
// }

///////////////////////////////////////////////////////////////////
// class CourseOneDetail {
//   final String name;
//   final String id;
//   final String address;
//   final String category;
//   final String distance;

//   CourseOneDetail({
//     required this.name,
//     required this.id,
//     required this.address,
//     required this.category,
//     required this.distance,
//   });

//   factory CourseOneDetail.fromJson(Map<String, dynamic> json) {
//     return CourseOneDetail(
//       name: json['name'],
//       id: json['id'],
//       address: json['address'],
//       category: json['category'],
//       distance: json['distance'],
//     );
//   }
// }

///////////////////////////////////////////////////////////////////

// class CourseThreeResponse {
//   final List<PlaceResultCourseThree> placeResultCourseThrees;
//   final String totalPrice;

//   CourseThreeResponse({
//     required this.placeResultCourseThrees,
//     required this.totalPrice,
//   });

//   factory CourseThreeResponse.fromJson(Map<String, dynamic> json) {
//     var list = json['placeResultCourseThrees'] as List;
//     List<PlaceResultCourseThree> places =
//         list.map((i) => PlaceResultCourseThree.fromJson(i)).toList();

//     return CourseThreeResponse(
//       placeResultCourseThrees: places,
//       totalPrice: json['totalPrice'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'placeResultCourseThrees':
//           placeResultCourseThrees.map((place) => place.toJson()).toList(),
//       'totalPrice': totalPrice,
//     };
//   }
// }

// class PlaceResultCourseThree {
//   final String name;
//   final String id;
//   final String address;
//   final String category;
//   final String price;

//   PlaceResultCourseThree({
//     required this.name,
//     required this.id,
//     required this.address,
//     required this.category,
//     required this.price,
//   });

///////////////////////////////////////////////////////////////////

// class SelectedCourse {
//   final String memberId;
//   final String course1;
//   final String course2;
//   final String course3;
//   final String course4;
//   final String course5;

//   SelectedCourse({
//     required this.memberId,
//     required this.course1,
//     required this.course2,
//     required this.course3,
//     required this.course4,
//     required this.course5,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'memberId': memberId,
//       'course1': course1,
//       'course2': course2,
//       'course3': course3,
//       'course4': course4,
//       'course5': course5,
//     };
//   }
// }

///////////////////////////////////////////////////////////////////

class Member {
  final String memberPartitionKey;
  final String memberSortKey;
  final String email;
  final String name;
  final String mapX;
  final String mapY;

  Member({
    required this.memberPartitionKey,
    required this.memberSortKey,
    required this.email,
    required this.name,
    required this.mapX,
    required this.mapY,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      memberPartitionKey: json['memberPartitionKey'],
      memberSortKey: json['memberSortKey'],
      email: json['email'],
      name: json['name'],
      mapX: json['mapX'],
      mapY: json['mapY'],
    );
  }
}

///////////////////////////////////////////////////////////////////

// 유저의 모든 코스 상세조회
class UserCourse {
  final String hotplacePartitionKey;
  final String hotplaceSortKey;
  final String name;
  final String mapX;
  final String mapY;
  final String category;
  final String address;
  final String? rating;
  final String imageUrl;
  final String placeUrl;
  final List<Menu> menus;
  final List<Keyword> keywords;

  UserCourse({
    required this.hotplacePartitionKey,
    required this.hotplaceSortKey,
    required this.name,
    required this.mapX,
    required this.mapY,
    required this.category,
    required this.address,
    this.rating,
    required this.imageUrl,
    required this.placeUrl,
    required this.menus,
    required this.keywords,
  });

  factory UserCourse.fromJson(Map<String, dynamic> json) {
    return UserCourse(
      hotplacePartitionKey: json['hotplacePartitionKey'],
      hotplaceSortKey: json['hotplaceSortKey'],
      name: json['name'],
      mapX: json['mapX'],
      mapY: json['mapY'],
      category: json['category'],
      address: json['address'],
      rating: json['rating'],
      imageUrl: json['imageUrl'],
      placeUrl: json['placeUrl'],
      menus: (json['menus'] as List).map((i) => Menu.fromJson(i)).toList(),
      keywords:
          (json['keywords'] as List).map((i) => Keyword.fromJson(i)).toList(),
    );
  }
}

// 실시간 실행중인 코스 조회
class MemberCourse {
  final String name;
  final String address;
  final String budget;
  final String congestion;
  final String mapX;
  final String mapY;
  final String imageUrl;
  final String time;

  MemberCourse({
    required this.name,
    required this.address,
    required this.budget,
    required this.congestion,
    required this.mapX,
    required this.mapY,
    required this.imageUrl,
    required this.time,
  });

  factory MemberCourse.fromJson(Map<String, dynamic> json) {
    return MemberCourse(
      name: json['name'],
      address: json['address'],
      budget: json['budget'],
      congestion: json['congestion'],
      mapX: json['mapX'],
      mapY: json['mapY'],
      imageUrl: json['imageUrl'],
      time: json['time'],
    );
  }
}

// 유저 시작 정보 업데이트
class MemberData {
  final String mapX;
  final String mapY;

  MemberData({required this.mapX, required this.mapY});

  factory MemberData.fromJson(Map<String, dynamic> json) {
    return MemberData(
      mapX: json['mapX'],
      mapY: json['mapY'],
    );
  }
}

// 코스 생성에 이용되는 함수
class ResultCourse {
  final String name;
  final String id;
  final String category;
  final String address;
  final String budget;
  final String congestion;
  final String mapX;
  final String mapY;
  final String? imageUrl;
  final String time;

  ResultCourse({
    required this.name,
    required this.id,
    required this.category,
    required this.address,
    required this.budget,
    required this.congestion,
    required this.mapX,
    required this.mapY,
    this.imageUrl,
    required this.time,
  });

  factory ResultCourse.fromJson(Map<String, dynamic> json) {
    return ResultCourse(
      name: json['name'],
      id: json['id'],
      category: json['category'],
      address: json['address'],
      budget: json['budget'],
      congestion: json['congestion'],
      mapX: json['mapX'],
      mapY: json['mapY'],
      imageUrl: json['imageUrl'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'category': category,
      'address': address,
      'budget': budget,
      'congestion': congestion,
      'mapX': mapX,
      'mapY': mapY,
      'imageUrl': imageUrl,
      'time': time,
    };
  }
}

// 코스 실행 및 저장 클래스
class CourseRunAndSaveModel {
  String memberId;
  String gu;
  String course1;
  String course2;
  String course3;
  String? course4;
  String? course5;

  CourseRunAndSaveModel({
    required this.memberId,
    required this.gu,
    required this.course1,
    required this.course2,
    required this.course3,
    this.course4,
    this.course5,
  });

  Map<String, dynamic> toJson() {
    return {
      'memberId': memberId,
      'gu': gu,
      'course1': course1,
      'course2': course2,
      'course3': course3,
      'course4': course4 ?? '',
      'course5': course5 ?? '',
    };
  }
}

// 요청 모델 (Request Models)
class Waypoint {
  final String name;
  final double x;
  final double y;

  Waypoint({
    required this.name,
    required this.x,
    required this.y,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'x': x,
      'y': y,
    };
  }
}

class DirectionsRequest {
  final double originX;
  final double originY;
  final double destinationX;
  final double destinationY;
  final List<Waypoint> waypoints;
  final String priority;
  final bool alternatives;
  final bool roadDetails;

  DirectionsRequest({
    required this.originX,
    required this.originY,
    required this.destinationX,
    required this.destinationY,
    required this.waypoints,
    required this.priority,
    required this.alternatives,
    required this.roadDetails,
  });

  Map<String, dynamic> toJson() {
    return {
      'origin': {'x': originX, 'y': originY},
      'destination': {'x': destinationX, 'y': destinationY},
      'waypoints': waypoints.map((w) => w.toJson()).toList(),
      'priority': priority,
      'alternatives': alternatives,
      'road_details': roadDetails,
    };
  }
}

// 응답 모델 (Response Models)
class Coordinates {
  final double x;
  final double y;

  Coordinates({
    required this.x,
    required this.y,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      x: json['x'],
      y: json['y'],
    );
  }
}

class Fare {
  final int taxi;
  final int toll;

  Fare({
    required this.taxi,
    required this.toll,
  });

  factory Fare.fromJson(Map<String, dynamic> json) {
    return Fare(
      taxi: json['taxi'],
      toll: json['toll'],
    );
  }
}

class Summary {
  final Coordinates origin;
  final Coordinates destination;
  final List<Coordinates> waypoints;
  final String priority;
  final Map<String, dynamic> bound;
  final Fare fare;
  final int distance;
  final int duration;

  Summary({
    required this.origin,
    required this.destination,
    required this.waypoints,
    required this.priority,
    required this.bound,
    required this.fare,
    required this.distance,
    required this.duration,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      origin: Coordinates.fromJson(json['origin']),
      destination: Coordinates.fromJson(json['destination']),
      waypoints: (json['waypoints'] as List)
          .map((wp) => Coordinates.fromJson(wp))
          .toList(),
      priority: json['priority'],
      bound: json['bound'],
      fare: Fare.fromJson(json['fare']),
      distance: json['distance'],
      duration: json['duration'],
    );
  }
}

class Road {
  final String name;
  final int distance;
  final int duration;
  final int trafficSpeed;
  final int trafficState;
  final List<double> vertexes;

  Road({
    required this.name,
    required this.distance,
    required this.duration,
    required this.trafficSpeed,
    required this.trafficState,
    required this.vertexes,
  });

  factory Road.fromJson(Map<String, dynamic> json) {
    return Road(
      name: json['name'],
      distance: json['distance'],
      duration: json['duration'],
      trafficSpeed: json['traffic_speed'],
      trafficState: json['traffic_state'],
      vertexes: List<double>.from(json['vertexes']),
    );
  }
}

class Guide {
  final String name;
  final double x;
  final double y;
  final int distance;
  final int duration;
  final int type;
  final String guidance;
  final int roadIndex;

  Guide({
    required this.name,
    required this.x,
    required this.y,
    required this.distance,
    required this.duration,
    required this.type,
    required this.guidance,
    required this.roadIndex,
  });

  factory Guide.fromJson(Map<String, dynamic> json) {
    return Guide(
      name: json['name'],
      x: json['x'],
      y: json['y'],
      distance: json['distance'],
      duration: json['duration'],
      type: json['type'],
      guidance: json['guidance'],
      roadIndex: json['road_index'],
    );
  }
}

class Section {
  final int distance;
  final int duration;
  final Map<String, dynamic> bound;
  final List<Road> roads;
  final List<Guide> guides;

  Section({
    required this.distance,
    required this.duration,
    required this.bound,
    required this.roads,
    required this.guides,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      distance: json['distance'],
      duration: json['duration'],
      bound: json['bound'],
      roads: (json['roads'] as List).map((r) => Road.fromJson(r)).toList(),
      guides: (json['guides'] as List).map((g) => Guide.fromJson(g)).toList(),
    );
  }
}

class Route {
  final int resultCode;
  final String resultMsg;
  final Summary summary;
  final List<Section> sections;

  Route({
    required this.resultCode,
    required this.resultMsg,
    required this.summary,
    required this.sections,
  });

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
      resultCode: json['result_code'],
      resultMsg: json['result_msg'],
      summary: Summary.fromJson(json['summary']),
      sections: (json['sections'] as List)
          .map((section) => Section.fromJson(section))
          .toList(),
    );
  }
}

class DirectionsResponse {
  final String transId;
  final List<Route> routes;

  DirectionsResponse({
    required this.transId,
    required this.routes,
  });

  factory DirectionsResponse.fromJson(Map<String, dynamic> json) {
    return DirectionsResponse(
      transId: json['trans_id'],
      routes: (json['routes'] as List)
          .map((route) => Route.fromJson(route))
          .toList(),
    );
  }
}

// 사용자 정보 받기
class UserData {
  final String email;
  final String name;

  UserData({required this.email, required this.name});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      email: json['email'],
      name: json['name'],
    );
  }
}
