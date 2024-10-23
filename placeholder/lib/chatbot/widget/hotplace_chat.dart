// import 'package:flutter/material.dart';
// import 'package:placeholder/chatbot/chatbot.dart';
// import 'package:placeholder/chatbot/model/chatbotmodel.dart';
// import 'package:placeholder/services/api.dart';
// import 'package:placeholder/services/model.dart';

// class CategoriesDisplay extends StatefulWidget {
//   final List<Category> restaurantCategories;
//   final List<Category> cafeCategories;
//   final List<Category> enterCategories;
//   final Function(Place) onPlaceSelected;

//   const CategoriesDisplay({
//     Key? key,
//     required this.restaurantCategories,
//     required this.cafeCategories,
//     required this.enterCategories,
//     required this.onPlaceSelected,
//   }) : super(key: key);

//   @override
//   _CategoriesDisplayState createState() => _CategoriesDisplayState();
// }

// class _CategoriesDisplayState extends State<CategoriesDisplay> {
//   late List<Category> restaurantCategories;
//   late List<Category> cafeCategories;
//   late List<Category> enterCategories;

//   @override
//   void initState() {
//     super.initState();
//     restaurantCategories = widget.restaurantCategories;
//     cafeCategories = widget.cafeCategories;
//     enterCategories = widget.enterCategories;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CategoryList(
//       categories: [
//         Category(
//           '음식점',
//           restaurantCategories.expand((cat) => cat.places).toList(),
//         ),
//         Category(
//           '카페',
//           cafeCategories.expand((cat) => cat.places).toList(),
//         ),
//         Category(
//           '놀거리',
//           enterCategories.expand((cat) => cat.places).toList(),
//         ),
//       ],
//       onPlaceSelected: widget.onPlaceSelected, // 장소 선택 핸들러
//     );
//   }
// }

// Future<List<CourseOneDetail>?> fetchCourseOne(
//     String address, String userEmail) async {
//   CourseRequestOne requestOne =
//       CourseRequestOne(address: address, userEmail: userEmail);

//   List<CourseOneDetail>? responseOne;
//   bool success = false;

//   while (!success) {
//     responseOne = await createCourseOne(requestOne);

//     if (responseOne != null) {
//       success = true;
//     } else {
//       await Future.delayed(Duration(seconds: 2)); // 2초 후 재시도
//     }
//   }

//   return responseOne;
// }

// Future<CourseThreeResponse?> fetchCourseThree(
//     String userEmail, int budget) async {
//   CourseRequestThree requestThree =
//       CourseRequestThree(userEmail: userEmail, budget: budget);

//   CourseThreeResponse? responseThree;
//   bool success = false;

//   while (!success) {
//     responseThree = await createCourseThree(requestThree);

//     if (responseThree != null) {
//       success = true;
//     } else {
//       await Future.delayed(Duration(seconds: 2)); // 2초 후 재시도
//     }
//   }

//   return responseThree;
// }
