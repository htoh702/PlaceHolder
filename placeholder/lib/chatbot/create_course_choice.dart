// import 'package:flutter/material.dart'; // Flutter의 기본 Material 디자인 라이브러리 임포트
// import 'package:placeholder/chatbot/widget/hotplace_chat.dart';
// import 'package:placeholder/services/model.dart';
// import '/chatbot/widget/choicewidget.dart'; // 위젯 파일 임포트

// // CreateCourseChoice 클래스: 코스 선택 화면을 담당하는 StatefulWidget입니다.
// class CreateCourseChoice extends StatefulWidget {
//   const CreateCourseChoice({Key? key}) : super(key: key);

//   @override
//   State<CreateCourseChoice> createState() => _CreateCourseChoiceState();
// }

// class _CreateCourseChoiceState extends State<CreateCourseChoice> {
//   int selectedCourse = 1; // 선택된 코스 번호를 저장하는 변수입니다.

//   List<CourseOneDetail>? courseOneDetails;
//   CourseThreeResponse? courseThreeResponse;

//   @override
//   void initState() {
//     super.initState();
//     _fetchCourseData();
//   }

//   Future<void> _fetchCourseData() async {
//     courseOneDetails = await fetchCourseOne('경기 성남시 분당구 양현로94번길 29', '1234');
//     courseThreeResponse = await fetchCourseThree('1234', 6000);

//     setState(() {});
//   }

//   // 코스를 선택하는 함수
//   void _selectCourse(int course) {
//     setState(() {
//       selectedCourse = course; // 선택된 코스로 상태를 변경합니다.
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100], // 배경 색상 설정
//       appBar: AppBar(
//         title: const Text('코스선택'), // 앱바의 타이틀 설정
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0), // 화면 패딩 설정
//         child: Column(
//           children: [
//             const SizedBox(height: 25),
//             const TopOfApp(), // 상단 앱 위젯
//             const SizedBox(height: 50),
//             Expanded(
//               child: ListView(
//                 children: [
//                   GestureDetector(
//                     onTap: () => _selectCourse(1), // 첫 번째 코스 선택 시
//                     child: CustomCourseCard(
//                       courseNumber: 1,
//                       selectedCourse: selectedCourse,
//                       courseOneDetails: courseOneDetails,
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                   GestureDetector(
//                     onTap: () => _selectCourse(2), // 두 번째 코스 선택 시
//                     child: const CustomCourseCard(
//                       courseNumber: 2,
//                       courseTwoText: '공사주웅',
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                   GestureDetector(
//                     onTap: () => _selectCourse(3), // 세 번째 코스 선택 시
//                     child: CustomCourseCard(
//                       courseNumber: 3,
//                       selectedCourse: selectedCourse,
//                       courseThreeResponse: courseThreeResponse,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         color: Colors.white, // 바텀 앱바 색상 설정
//         child: Center(
//           child: RouteButton(
//             width: 350, // 버튼 너비 고정
//             height: 70, // 버튼 높이 고정
//             selectedCourse: selectedCourse,
//           ),
//         ),
//       ),
//     );
//   }
// }
