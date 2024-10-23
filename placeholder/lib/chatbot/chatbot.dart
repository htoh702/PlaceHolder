// import 'package:flutter/material.dart'; // Flutter의 기본 위젯 및 머터리얼 디자인 라이브러리
// import 'package:carousel_slider/carousel_slider.dart'; // CarouselSlider 라이브러리
// import 'package:go_router/go_router.dart'; // GoRouter 라우팅 라이브러리
// import 'package:placeholder/chatbot/widget/hotplace_chat.dart';
// import 'package:placeholder/globals.dart';
// import 'package:placeholder/services/api.dart';
// import 'package:placeholder/services/model.dart';
// import 'package:placeholder/chatbot/model/chatbotmodel.dart';
// import 'package:placeholder/auth_service.dart';

// // ChatBotPage 클래스 정의
// class ChatBotPage extends StatefulWidget {
//   const ChatBotPage({Key? key}) : super(key: key);

//   @override
//   _ChatBotPageState createState() => _ChatBotPageState(); // 상태 클래스 생성
// }

// // ChatBotPage 상태 클래스 정의
// class _ChatBotPageState extends State<ChatBotPage> {
//   final List<ChatMessage> _messages = []; // 채팅 메시지 리스트
//   final List<Place> _tempselectedPlaces = []; // 임시 선택된 장소 리스트
//   final List<Place> _selectedPlaces = []; // 최종 선택된 장소 리스트
//   final ScrollController _scrollController = ScrollController(); // 스크롤 컨트롤러
//   final String selectedHotPlace = '';
//   List<Category> restaurantCategories = [];
//   List<Category> cafeCategories = [];
//   List<Category> enterCategories = [];

//   @override
//   void initState() {
//     super.initState();
//     sharedData.addListener(_onSharedDataChanged);
//     selectedPlace.addListener(_fetchCategories);
//     _onSharedDataChanged();
//     _fetchCategories();
//     _sendMessage('');
//   }

//   void showTemporaryOverlay(BuildContext context) {
//     OverlayEntry overlayEntry = OverlayEntry(
//       builder: (context) => Positioned(
//         top: MediaQuery.of(context).size.height / 2 - 50,
//         left: MediaQuery.of(context).size.width / 2 - 100,
//         child: Material(
//           color: Colors.transparent,
//           child: Container(
//             width: 200,
//             height: 100,
//             color: Colors.black.withOpacity(0.7),
//             child: Center(
//               child: Text(
//                 '예산 ㄱㄱ',
//                 style: TextStyle(color: Colors.white, fontSize: 16),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//     Overlay.of(context)?.insert(overlayEntry);
//     Future.delayed(Duration(seconds: 2), () {
//       overlayEntry.remove();
//     });
//   }

//   Future<void> _fetchCategories() async {
//     if (selectedPlace.value == null) return;

//     try {
//       List<ChatBotPlace> restaurantPlaces =
//           await fetchPlaces(selectedPlace.value!.areaCd, 'restaurant');
//       List<ChatBotPlace> cafePlaces =
//           await fetchPlaces(selectedPlace.value!.areaCd, 'cafe');
//       List<ChatBotPlace> entertainmentPlaces =
//           await fetchPlaces(selectedPlace.value!.areaCd, 'enter');
//       print(selectedPlace.value!.areaCd);

//       setState(() {
//         restaurantCategories = [
//           Category(
//             '음식점',
//             restaurantPlaces
//                 .map((place) => Place(place.place_name, place.address_name,
//                     place.image_url, place.id, place.category_group_name))
//                 .toList(),
//           )
//         ];

//         cafeCategories = [
//           Category(
//             '카페',
//             cafePlaces
//                 .map((place) => Place(place.place_name, place.address_name,
//                     place.image_url, place.id, place.category_group_name))
//                 .toList(),
//           )
//         ];

//         enterCategories = [
//           Category(
//             '놀거리',
//             entertainmentPlaces
//                 .map((place) => Place(place.place_name, place.address_name,
//                     place.image_url, place.id, place.category_group_name))
//                 .toList(),
//           )
//         ];
//       });
//     } catch (e) {
//       print('Failed to fetch categories: $e');
//     }
//   }

//   // 메시지를 전송하는 함수
//   void _sendMessage(String text) {
//     if (text.isEmpty) return; // 텍스트가 비어있으면 종료

//     setState(() {
//       _messages.add(ChatMessage(text: text, isUser: true)); // 사용자 메시지 추가

//       // 비동기적으로 봇 응답 추가
//       Future.delayed(const Duration(seconds: 1), () {
//         setState(() {
//           if (text == '장소추천') {
//             _messages.add(ChatMessage(
//                 text: '음식점, 카페, 놀거리', isUser: false)); // 장소추천에 대한 봇 응답
//           } else {
//             _messages.add(
//                 ChatMessage(text: '봇 응답: $text', isUser: false)); // 일반 봇 응답
//           }
//           _scrollToBottom(); // 스크롤을 아래로 이동
//         });
//       });
//       _scrollToBottom(); // 스크롤을 아래로 이동
//     });
//   }

//   void _onSharedDataChanged() {
//     fetchHotPlaces(sharedData.value).then((places) {
//       setState(() {
//         _messages.add(ChatMessage(
//           text: "Location : ${sharedData.value}",
//           isUser: false,
//         ));
//       });
//       _showPlacesDialog(places);
//       _scrollToBottom();
//     }).catchError((error) {
//       setState(() {
//         _messages.add(ChatMessage(
//           text: 'Error: $error',
//           isUser: false,
//         ));
//       });
//       _scrollToBottom();
//     });
//   }

//   void _showPlacesDialog(List<HotPlace> places) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Center(child: Text('Choose Hot Places')),
//           content: Container(
//             width: MediaQuery.of(context).size.width * 0.3,
//             child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: places.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Center(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                     child: SizedBox(
//                       width: 200, // 고정된 너비 설정
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           foregroundColor: Colors.white,
//                           backgroundColor: Colors.grey.withOpacity(0.3),
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 20, vertical: 10),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         child: Text(places[index].name),
//                         onPressed: () {
//                           setState(() {
//                             selectedPlace.value = places[index];
//                           });
//                           Navigator.of(context).pop();
//                           print(selectedPlace.value!.areaCd);
//                           setState(() {
//                             _messages.add(ChatMessage(
//                               text: "Hot Place : ${selectedPlace.value!.name}",
//                               isUser: false,
//                             ));
//                           });
//                           _scrollToBottom();
//                         },
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }

//   // 스크롤을 아래로 이동하는 함수
//   void _scrollToBottom() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_scrollController.hasClients) {
//         _scrollController.animateTo(
//           _scrollController.position.maxScrollExtent,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }

//   // 임시 선택된 장소를 장바구니에 추가하는 함수
//   void _addToCart() {
//     setState(() {
//       for (Place place in _tempselectedPlaces) {
//         if (!_selectedPlaces.contains(place)) {
//           _selectedPlaces.add(place);
//         }
//       }
//       _tempselectedPlaces.clear(); // 임시 선택된 장소 초기화
//     });
//   }

//   // 장소 선택을 토글하는 함수
//   void _togglePlaceSelection(Place place) {
//     setState(() {
//       if (_tempselectedPlaces.contains(place)) {
//         _tempselectedPlaces.remove(place); // 임시 선택 목록에서 제거
//       } else {
//         _tempselectedPlaces.add(place); // 임시 선택 목록에 추가
//       }
//       place.isSelected = !place.isSelected; // 선택 상태 토글
//     });
//   }

//   // 장바구니에서 장소를 제거하는 함수
//   void _removeFromCart(Place place) {
//     setState(() {
//       _selectedPlaces.remove(place); // 장바구니에서 장소 제거
//     });
//   }

//   // 장소를 카테고리별로 그룹화하는 함수
//   Map<String, List<Place>> _groupPlacesByCategory() {
//     Map<String, List<Place>> groupedPlaces = {
//       '음식점': [],
//       '카페': [],
//       '놀거리': [],
//     };

//     for (var place in _selectedPlaces) {
//       if (place.name.contains('음식점')) {
//         groupedPlaces['음식점']!.add(place); // '음식점' 카테고리에 추가
//       } else if (place.name.contains('카페')) {
//         groupedPlaces['카페']!.add(place); // '카페' 카테고리에 추가
//       } else if (place.name.contains('놀거리')) {
//         groupedPlaces['놀거리']!.add(place); // '놀거리' 카테고리에 추가
//       }
//     }

//     return groupedPlaces; // 그룹화된 장소 반환
//   }

//   Future<List<PlaceDetail>> fetchAndReturnPlaceDetails(String userId) async {
//     List<PlaceDetail> placeDetailsList = [];
//     print(subID);
//     CourseData? courseData = await fetchCourseData(userId);

//     if (courseData == null) {
//       print('No course data found for user: $userId');
//       return placeDetailsList;
//     }

//     for (String courseId in courseData.courses.values) {
//       try {
//         PlaceDetail placeDetail = await fetchPlaceDetail(courseId);
//         placeDetailsList.add(placeDetail);
//       } catch (e) {
//         print('Failed to fetch place detail for course ID: $courseId');
//         PlaceDetail placeDetail = PlaceDetail(
//           areaCd: '자동',
//           placeName: '자동',
//           addressName: '자동',
//           categoryGroupName: '자동',
//           placeUrl: '',
//           imageUrl: '',
//           x: '',
//           y: '',
//         );
//         placeDetailsList.add(placeDetail);
//       }
//     }

//     return placeDetailsList;
//   }

//   // 장바구니를 표시하는 함수
//   void _showCartBottomSheet() async {
//     List<PlaceDetail> placeDetails =
//         await fetchAndReturnPlaceDetails(subID.value);

//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
//       ),
//       builder: (BuildContext context) {
//         return Container(
//           height: 400,
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(25),
//               topRight: Radius.circular(25),
//             ),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: const Text(
//                   '장바구니',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: placeDetails.isEmpty
//                     ? Center(
//                         child: Text(
//                           '장바구니가 비어 있습니다.',
//                           style: TextStyle(fontSize: 18, color: Colors.grey),
//                         ),
//                       )
//                     : ListView.builder(
//                         itemCount: placeDetails.length,
//                         itemBuilder: (context, index) {
//                           return ListTile(
//                             leading: Icon(Icons.place),
//                             title: Text(placeDetails[index].placeName),
//                             subtitle:
//                                 Text(placeDetails[index].categoryGroupName),
//                             trailing: IconButton(
//                               icon: const Icon(Icons.remove_circle,
//                                   color: Colors.red),
//                               onPressed: () {
//                                 // 필요 시 삭제 로직 추가
//                               },
//                             ),
//                           );
//                         },
//                       ),
//               ),
//               ElevatedButton(
//                 child: const Text('닫기'),
//                 onPressed: () {
//                   Navigator.pop(context); // 장바구니 닫기
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFFFABC85), // 버튼 배경색
//                   foregroundColor: Colors.black, // 버튼 텍스트 색상
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 20.0, // 수평 패딩
//                     vertical: 15.0, // 수직 패딩
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15.0), // 둥근 모서리
//                   ),
//                   textStyle: const TextStyle(
//                     fontSize: 16.0, // 텍스트 크기
//                     fontWeight: FontWeight.bold, // 텍스트 굵기
//                   ),
//                   shadowColor: Colors.black, // 그림자 색상
//                   elevation: 5.0, // 그림자 깊이
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   void dispose() {
//     sharedData.removeListener(_onSharedDataChanged);
//     selectedPlace.removeListener(_fetchCategories);
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('ChatBot 코스생성'), // 앱바 제목
//         backgroundColor: const Color(0xFFFABC85), // 앱바 배경색
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: LayoutBuilder(
//               builder: (context, constraints) {
//                 double horizontalPadding = (constraints.maxWidth - 700) / 2;
//                 horizontalPadding = horizontalPadding.clamp(16, 700);

//                 return ListView.builder(
//                   controller: _scrollController,
//                   padding: EdgeInsets.symmetric(
//                     horizontal: horizontalPadding,
//                     vertical: 8.0,
//                   ),
//                   itemCount: _messages.length, // 메시지 개수
//                   itemBuilder: (context, index) {
//                     var message = _messages[index];
//                     if (message.text == '음식점, 카페, 놀거리') {
//                       return CategoriesDisplay(
//                         restaurantCategories: restaurantCategories,
//                         cafeCategories: cafeCategories,
//                         enterCategories: enterCategories,
//                         onPlaceSelected: _togglePlaceSelection, // 장소 선택 핸들러
//                       );
//                     }
//                     return ChatBubble(
//                       message: message.text,
//                       isUser: message.isUser,
//                       horizontalPadding: 24.0,
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Wrap(
//               alignment: WrapAlignment.center,
//               spacing: 8.0,
//               runSpacing: 8.0,
//               children: [
//                 QuickReplyButton(
//                   onPressed: () {
//                     context.go('/main/chatbot/select');
//                   },
//                   label: '지역변경',
//                 ),
//                 QuickReplyButton(
//                   onPressed: () {
//                     _sendMessage('장소추천');
//                   },
//                   label: '장소추천',
//                 ),
//                 QuickReplyButton(
//                   onPressed: () {
//                     _sendMessage('지도보기');
//                   },
//                   label: '지도보기',
//                 ),
//                 QuickReplyButton(
//                   onPressed: () {
//                     print(startAddress.value);
//                     _showCartBottomSheet();
//                   },
//                   label: '장바구니',
//                 ),
//                 QuickReplyButton(
//                   onPressed: () {
//                     _showInputDialog(context);
//                   },
//                   label: '코스생성',
//                 ),
//                 QuickReplyButton(
//                   onPressed: () {
//                     context.go('/main');
//                   },
//                   label: '나가기',
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showInputDialog(BuildContext context) {
//     TextEditingController textController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Input Required'),
//           content: TextField(
//             controller: textController,
//             decoration: InputDecoration(hintText: "Enter Budget"),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text('Submit'),
//               onPressed: () {
//                 String inputText = textController.text;
//                 if (inputText.isNotEmpty) {
//                   budget.value = inputText;
//                   Navigator.of(context).pop();
//                   context.go('/main/chatbot/emergency');
//                 } else {
//                   showTemporaryOverlay(context);
//                 }
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// // 채팅 메시지 클래스 정의
// class ChatMessage {
//   final String text; // 메시지 텍스트
//   final bool isUser; // 사용자가 보낸 메시지인지 여부

//   ChatMessage({required this.text, required this.isUser}); // 생성자
// }

// // 채팅 버블 위젯 정의
// class ChatBubble extends StatelessWidget {
//   final String message; // 메시지 텍스트
//   final bool isUser; // 사용자가 보낸 메시지인지 여부
//   final double horizontalPadding; // 수평 패딩

//   const ChatBubble({
//     Key? key,
//     required this.message,
//     required this.isUser,
//     this.horizontalPadding = 8.0,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8.0),
//       alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: horizontalPadding),
//         padding: const EdgeInsets.all(12.0),
//         decoration: BoxDecoration(
//           color: isUser ? const Color(0xFFFABC85) : Colors.grey.shade300,
//           borderRadius: BorderRadius.only(
//             topLeft: const Radius.circular(16.0),
//             topRight: const Radius.circular(16.0),
//             bottomLeft:
//                 isUser ? const Radius.circular(16.0) : const Radius.circular(0),
//             bottomRight:
//                 isUser ? const Radius.circular(0) : const Radius.circular(16.0),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               spreadRadius: 2,
//               blurRadius: 4,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Text(
//           message,
//           style: const TextStyle(
//             color: Colors.black,
//             fontSize: 16.0,
//           ),
//         ),
//       ),
//     );
//   }
// }

// // 퀵 리플라이 버튼 위젯 정의
// class QuickReplyButton extends StatelessWidget {
//   final VoidCallback onPressed; // 버튼 클릭 시 호출할 함수
//   final String label; // 버튼 레이블

//   const QuickReplyButton({
//     Key? key,
//     required this.onPressed,
//     required this.label,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: Container(
//         width: 120.0,
//         height: 50.0,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10.0),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.3),
//               spreadRadius: 3,
//               blurRadius: 5,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Center(
//           child: Text(
//             label,
//             style: const TextStyle(
//               fontSize: 14.0,
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ),
//     );
//   }
// }

// // 카테고리 리스트 위젯 정의
// class CategoryList extends StatefulWidget {
//   final List<Category> categories; // 카테고리 리스트
//   final double carouselHeight; // 캐러셀 높이
//   final Color backgroundColor; // 배경 색상
//   final Color textColor; // 텍스트 색상
//   final double textSize; // 텍스트 크기
//   final Function(Place) onPlaceSelected; // 장소 선택 시 호출할 함수

//   const CategoryList({
//     Key? key,
//     required this.categories,
//     this.carouselHeight = 200.0,
//     this.backgroundColor = Colors.white,
//     this.textColor = Colors.black,
//     this.textSize = 14.0,
//     required this.onPlaceSelected,
//   }) : super(key: key);

//   @override
//   _CategoryListState createState() => _CategoryListState();
// }

// class _CategoryListState extends State<CategoryList> {
//   Future<void> _toggleButton(Category category) async {
//     setState(() {
//       category.isOn = !category.isOn;
//     });
//     AutoPostData postData = AutoPostData(
//         memberEmail: subID.value,
//         hotPlaceId: selectedPlace.value!.areaCd,
//         category: category.name);
//     if (category.isOn) {
//       print(category.name);
//       print(category.isOn);
//       await sendAutoPostRequest(postData);
//     } else {
//       print(category.name);
//       print(category.isOn);
//       await deleteAutoPostRequest(postData);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: widget.categories.map((category) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Row(
//                 children: [
//                   Text(
//                     category.name,
//                     style: const TextStyle(
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blue,
//                     ),
//                   ),
//                   const SizedBox(width: 8.0),
//                   Text(
//                     '(${category.places.length})',
//                     style: const TextStyle(
//                       fontSize: 16.0,
//                       color: Colors.black,
//                     ),
//                   ),
//                   const SizedBox(width: 8.0),
//                   // 랜덤 버튼 추가
//                   ElevatedButton(
//                     onPressed: () => _toggleButton(category),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor:
//                           category.isOn ? Colors.green : Colors.blue, // 버튼 배경색
//                       foregroundColor: Colors.white, // 버튼 텍스트 색상
//                       shadowColor: Colors.black, // 그림자 색상
//                       elevation: 5, // 그림자 깊이
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12), // 버튼 모서리 반경
//                       ),
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 20,
//                         vertical: 10,
//                       ), // 버튼 패딩
//                     ),
//                     child: Text(category.isOn ? '-완-' : '랜덤',
//                         style: TextStyle(fontSize: 16)), // 버튼 텍스트
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 8.0),
//             LayoutBuilder(
//               builder: (context, constraints) {
//                 double viewportFraction = constraints.maxWidth < 600
//                     ? 0.8
//                     : (constraints.maxWidth < 1000 ? 0.6 : 0.4);

//                 return CarouselSlider(
//                   options: CarouselOptions(
//                     height: 350, // 캐러셀 높이
//                     enlargeCenterPage: true, // 중앙 페이지 확대
//                     aspectRatio: 16 / 9, // 화면 비율
//                     viewportFraction: viewportFraction, // 뷰포트 비율
//                     initialPage: 0, // 초기 페이지
//                     enableInfiniteScroll: false, // 무한 스크롤 비활성화
//                   ),
//                   items: category.places.map((place) {
//                     return Builder(
//                       builder: (BuildContext context) {
//                         return Container(
//                           width: 350, // 각 항목의 너비
//                           margin: const EdgeInsets.symmetric(
//                               horizontal: 5.0), // 수평 마진
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10.0), // 모서리 반경
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.3),
//                                 spreadRadius: 3,
//                                 blurRadius: 5,
//                                 offset: const Offset(0, 3),
//                               ),
//                             ],
//                           ),
//                           child: ClipRRect(
//                             borderRadius:
//                                 BorderRadius.circular(10.0), // 이미지 클립 반경
//                             child: PlaceBubble(
//                               place: place,
//                               backgroundColor: widget.backgroundColor, // 배경 색상
//                               textColor: widget.textColor, // 텍스트 색상
//                               textSize: widget.textSize, // 텍스트 크기
//                               height: widget.carouselHeight, // 캐러셀 높이
//                               onPlaceSelected:
//                                   widget.onPlaceSelected, // 장소 선택 핸들러
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   }).toList(),
//                 );
//               },
//             ),
//             const SizedBox(height: 16.0), // 카테고리 간의 공간
//           ],
//         );
//       }).toList(),
//     );
//   }
// }

// // 장소 버블 위젯 정의
// class PlaceBubble extends StatefulWidget {
//   final Place place; // 장소 객체
//   final Color backgroundColor; // 배경 색상
//   final Color textColor; // 텍스트 색상
//   final double textSize; // 텍스트 크기
//   final double height; // 버블 높이
//   final Function(Place) onPlaceSelected; // 장소 선택 핸들러

//   const PlaceBubble({
//     Key? key,
//     required this.place,
//     this.backgroundColor = Colors.grey,
//     this.textColor = Colors.black,
//     this.textSize = 14.0,
//     this.height = 200.0,
//     required this.onPlaceSelected,
//   }) : super(key: key);

//   @override
//   _PlaceBubbleState createState() => _PlaceBubbleState(); // 상태 클래스 생성
// }

// // PlaceBubble 상태 클래스 정의
// class _PlaceBubbleState extends State<PlaceBubble> {
//   late bool isSelected; // 선택 여부 상태

//   @override
//   void initState() {
//     super.initState();
//     isSelected = widget.place.isSelected; // 초기 선택 상태 설정
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.symmetric(vertical: 4.0),
//       padding: const EdgeInsets.all(12.0),
//       decoration: BoxDecoration(
//         color: widget.backgroundColor,
//         borderRadius: BorderRadius.circular(8.0),
//         border: Border.all(color: Colors.grey.shade300),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3),
//             spreadRadius: 3,
//             blurRadius: 5,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Stack(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               AspectRatio(
//                 aspectRatio: 16 / 9,
//                 child: Image.network(
//                   widget.place.imageUrl,
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                   height: double.infinity,
//                   errorBuilder: (BuildContext context, Object exception,
//                       StackTrace? stackTrace) {
//                     return Center(
//                       child: Icon(
//                         Icons.error,
//                         color: Colors.red,
//                         size: 50.0,
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               const SizedBox(height: 8.0),
//               Text(
//                 widget.place.name,
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: widget.textColor,
//                 ),
//               ),
//               const SizedBox(height: 4.0),
//               Text(
//                 widget.place.description,
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: widget.textColor,
//                 ),
//               ),
//             ],
//           ),
//           Positioned(
//             top: 8,
//             right: 8,
//             child: GestureDetector(
//               onTap: () async {
//                 NonAutoPostData postData = NonAutoPostData(
//                   memberEmail: subID.value,
//                   kakaoId: widget.place.id,
//                   category: widget.place.category,
//                 );

//                 if (isSelected) {
//                   await deleteNonAutoPostRequest(postData);
//                   setState(() {
//                     isSelected = false;
//                     courseCounter.value -= 1;
//                     widget.place.isSelected = isSelected; // 선택 상태 업데이트
//                     widget.onPlaceSelected(widget.place); // 선택된 장소 전달
//                   });
//                 } else if (courseCounter.value < 5) {
//                   await sendNonAutoPostRequest(postData);
//                   setState(() {
//                     isSelected = true;
//                     courseCounter.value += 1;
//                     widget.place.isSelected = isSelected; // 선택 상태 업데이트
//                     widget.onPlaceSelected(widget.place); // 선택된 장소 전달
//                   });
//                 }
//               },
//               child: Container(
//                 width: 28.0,
//                 height: 28.0,
//                 decoration: BoxDecoration(
//                   color: isSelected
//                       ? Colors.green
//                       : Colors.orange, // 선택 상태에 따른 색상 변경
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     color: Colors.white,
//                     width: 2.0,
//                   ),
//                 ),
//                 child: Center(
//                   child: Icon(
//                     isSelected ? Icons.check : Icons.add,
//                     color: Colors.white,
//                     size: 16.0,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
