// import 'package:flutter/material.dart'; // Flutter의 기본 Material 디자인 라이브러리 임포트
// import 'package:go_router/go_router.dart';
// import 'package:placeholder/globals.dart';
// import 'package:placeholder/services/api.dart';
// import 'package:placeholder/services/model.dart'; // 경로 관리를 위한 go_router 라이브러리 임포트

// // TopOfApp 클래스: 애플리케이션의 상단 부분을 구성하는 위젯입니다.
// class TopOfApp extends StatelessWidget {
//   const TopOfApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       // Column 위젯을 사용하여 자식 위젯을 수직으로 배치
//       children: [
//         Row(
//           // Row 위젯을 사용하여 자식 위젯을 수평으로 배치
//           mainAxisAlignment: MainAxisAlignment.center, // 수평 중앙 정렬
//           children: [
//             Container(
//               // 이미지 컨테이너
//               width: 50, // 컨테이너 너비 설정
//               height: 50, // 컨테이너 높이 설정
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage(
//                       'assets/images/placeholder_elephant.png'), // 애셋 이미지 설정
//                   fit: BoxFit.contain, // 이미지를 컨테이너에 맞춰 표시
//                 ),
//               ),
//             ),
//             const SizedBox(width: 10), // 이미지와 텍스트 사이의 간격 설정
//             const Text(
//               '추천 코스 중 하나를 선택하세요!', // 안내 텍스트
//               style: TextStyle(
//                 fontWeight: FontWeight.bold, // 텍스트 두께 설정
//                 fontSize: 20, // 텍스트 크기 설정
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class CustomCourseCard extends StatelessWidget {
//   final int courseNumber; // 코스 번호를 저장하는 변수
//   final int? selectedCourse; // 선택된 코스 번호를 저장하는 변수
//   final List<CourseOneDetail>? courseOneDetails; // 코스 원 디테일 리스트
//   final CourseThreeResponse? courseThreeResponse; // 코스 쓰리 디테일 리스트
//   final String? courseTwoText; // 두 번째 코스 텍스트

//   const CustomCourseCard({
//     required this.courseNumber, // 필수 파라미터 courseNumber
//     this.selectedCourse, // 선택적 파라미터 selectedCourse
//     this.courseOneDetails, // 코스 원 디테일 리스트
//     this.courseThreeResponse, // 코스 쓰리 디테일 리스트
//     this.courseTwoText, // 두 번째 코스 텍스트
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     String courseTitle;
//     switch (courseNumber) {
//       case 1:
//         courseTitle = '거리에 따른 코스 추천';
//         break;
//       case 2:
//         courseTitle = '인구 혼잡도에 따른 코스 추천';
//         break;
//       case 3:
//         courseTitle = '예산에 따른 코스 추천';
//         break;
//       default:
//         courseTitle = '코스 추천';
//     }

//     return Card(
//       // 카드 형태의 위젯
//       elevation: 5, // 카드의 그림자 깊이 설정
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0), // 카드 모서리를 둥글게 설정
//       ),
//       shadowColor: selectedCourse == courseNumber
//           ? Colors.orangeAccent // 선택된 경우 주황색 그림자
//           : Colors.grey, // 선택되지 않은 경우 회색 그림자
//       child: Container(
//         // 카드 내용을 담는 컨테이너
//         width: double.infinity, // 부모 위젯에 맞춰 너비 설정
//         height: 140, // 높이 설정
//         padding: const EdgeInsets.all(16.0), // 패딩 설정
//         decoration: BoxDecoration(
//           gradient: selectedCourse == courseNumber
//               ? const LinearGradient(
//                   colors: [
//                     Color(0xFFFABC85),
//                     Color(0xFFFA8C85)
//                   ], // 선택된 경우 그라디언트 색상
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 )
//               : null, // 선택되지 않은 경우 그라디언트 없음
//           borderRadius: BorderRadius.circular(15.0), // 모서리를 둥글게 설정
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start, // 아이템을 상단에 정렬
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               courseTitle, // 코스 번호에 따른 텍스트
//               style: TextStyle(
//                 color: selectedCourse == courseNumber
//                     ? Colors.white // 선택된 경우 흰색 텍스트
//                     : Colors.black, // 선택되지 않은 경우 검은색 텍스트
//                 fontWeight: FontWeight.bold, // 텍스트 두께 설정
//                 fontSize: 18, // 텍스트 크기 설정
//               ),
//             ),
//             const SizedBox(height: 10), // 텍스트와 다음 요소 사이의 간격 설정
//             if (courseNumber == 1 && courseOneDetails != null) ...[
//               Expanded(
//                 child: Row(
//                   children: courseOneDetails!.map((detail) {
//                     int flexValue =
//                         (double.parse(detail.distance) * 100).toInt();
//                     flexValue = flexValue < 1 ? 1 : flexValue;
//                     return Expanded(
//                       flex: flexValue,
//                       child: CourseBar(
//                         category: detail.category,
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//               Row(
//                 children: courseOneDetails!.map((detail) {
//                   int flexValue = (double.parse(detail.distance) * 100).toInt();
//                   flexValue = flexValue < 1 ? 1 : flexValue;
//                   return Expanded(
//                     flex: flexValue,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(height: 4),
//                         Text(
//                           detail.name,
//                           style: TextStyle(
//                             color: selectedCourse == courseNumber
//                                 ? Colors.white
//                                 : Colors.black,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ],
//             if (courseNumber == 3 && courseThreeResponse != null) ...[
//               Expanded(
//                 child: Row(
//                   children: courseThreeResponse!.placeResultCourseThrees
//                       .map((detail) {
//                     String priceString =
//                         detail.price.replaceAll(",", "").replaceAll("원", "");
//                     int flexValue = int.parse(priceString);
//                     flexValue = flexValue < 1 ? 1 : flexValue;
//                     return Expanded(
//                       flex: flexValue,
//                       child: CourseBar(
//                         category: detail.category,
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//               Row(
//                 children:
//                     courseThreeResponse!.placeResultCourseThrees.map((detail) {
//                   String priceString =
//                       detail.price.replaceAll(",", "").replaceAll("원", "");
//                   int flexValue = int.parse(priceString);
//                   flexValue = flexValue < 1 ? 1 : flexValue;
//                   return Expanded(
//                     flex: flexValue,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(height: 4),
//                         Text(
//                           detail.name,
//                           style: TextStyle(
//                             color: selectedCourse == courseNumber
//                                 ? Colors.white
//                                 : Colors.black,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ],
//             if (courseTwoText != null && courseNumber == 2) ...[
//               Text(
//                 courseTwoText!,
//                 style: TextStyle(
//                   color: selectedCourse == courseNumber
//                       ? Colors.white
//                       : Colors.black,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }

// // RouteButton 클래스: 특정 경로로 이동하는 버튼 위젯입니다.
// class RouteButton extends StatelessWidget {
//   final double width;
//   final double height;
//   final int selectedCourse;
//   final List<CourseOneDetail>? courseOneDetails;
//   final CourseThreeResponse? courseThreeResponse;

//   const RouteButton({
//     Key? key,
//     required this.width,
//     required this.height,
//     required this.selectedCourse,
//     this.courseOneDetails,
//     this.courseThreeResponse,
//   }) : super(key: key);

//   Future<void> _handleButtonPress(BuildContext context) async {
//     SelectedCourse courseRequest;

//     if (selectedCourse == 1 && courseOneDetails != null) {
//       courseRequest = SelectedCourse(
//         memberId: subID.value,
//         course1: courseOneDetails!.isNotEmpty ? courseOneDetails![0].id : '',
//         course2: courseOneDetails!.length > 1 ? courseOneDetails![1].id : '',
//         course3: courseOneDetails!.length > 2 ? courseOneDetails![2].id : '',
//         course4: courseOneDetails!.length > 3 ? courseOneDetails![3].id : '',
//         course5: courseOneDetails!.length > 4 ? courseOneDetails![4].id : '',
//       );
//     } else if (selectedCourse == 3 && courseThreeResponse != null) {
//       courseRequest = SelectedCourse(
//         memberId: subID.value,
//         course1: courseThreeResponse!.placeResultCourseThrees.isNotEmpty
//             ? courseThreeResponse!.placeResultCourseThrees[0].id
//             : '',
//         course2: courseThreeResponse!.placeResultCourseThrees.length > 1
//             ? courseThreeResponse!.placeResultCourseThrees[1].id
//             : '',
//         course3: courseThreeResponse!.placeResultCourseThrees.length > 2
//             ? courseThreeResponse!.placeResultCourseThrees[2].id
//             : '',
//         course4: courseThreeResponse!.placeResultCourseThrees.length > 3
//             ? courseThreeResponse!.placeResultCourseThrees[3].id
//             : '',
//         course5: courseThreeResponse!.placeResultCourseThrees.length > 4
//             ? courseThreeResponse!.placeResultCourseThrees[4].id
//             : '',
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Invalid course selection')),
//       );
//       return;
//     }

//     try {
//       await selectedCourseRequest(courseRequest);
//       await deleteCourseCart(subID.value);
//       context.go('/main/real');
//     } catch (e, stacktrace) {
//       print('Exception during API calls: $e');
//       print('Stacktrace: $stacktrace');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: width,
//       height: height,
//       child: ElevatedButton(
//         onPressed: () => _handleButtonPress(context),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFFFABC85),
//         ),
//         child: const Text(
//           '코스 선택',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 16,
//             color: Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CourseBar extends StatelessWidget {
//   final String category;

//   const CourseBar({
//     super.key,
//     required this.category,
//   });

//   @override
//   Widget build(BuildContext context) {
//     Color getCategoryColor(String category) {
//       switch (category) {
//         case '음식점':
//           return Colors.redAccent;
//         case '카페':
//           return Colors.yellowAccent;
//         case '놀거리':
//           return Colors.orange;
//         default:
//           return Colors.grey;
//       }
//     }

//     return Container(
//       height: 20,
//       decoration: BoxDecoration(
//         color: getCategoryColor(category),
//         borderRadius: BorderRadius.circular(10.0), // 모서리를 둥글게 설정
//       ),
//     );
//   }
// }
