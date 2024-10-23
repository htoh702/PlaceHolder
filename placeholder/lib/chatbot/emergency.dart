import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:placeholder/globals.dart';
import 'package:placeholder/services/api.dart';
import 'package:placeholder/services/model.dart';

class Emergency extends StatefulWidget {
  @override
  _EmergencyState createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
  List<ResultCourse> courseDetailsOne = [];
  List<ResultCourse> courseDetailsTwo = [];
  List<ResultCourse> courseDetailsThree = [];
  bool isLoadingOne = false;
  bool isLoadingTwo = false;
  bool isLoadingThree = false;
  String errorMessage = '';
  int selectedCourse = 0;
  ResultCourse? selectedCourseDetail;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    const int maxRetries = 3;
    int retryCount = 0;
    bool success = false;

    setState(() {
      isLoadingOne = true;
      isLoadingTwo = true;
      isLoadingThree = true;
    });

    while (!success && retryCount < maxRetries) {
      try {
        final courseData = await createCourse({
          "memberId": subID.value,
          "gu": sharedData.value,
          "parameter1": param1.value,
          "parameter2": param2.value,
          "parameter3": param3.value,
        });

        setState(() {
          courseDetailsOne = courseData[0];
          courseDetailsTwo = courseData[1];
          courseDetailsThree = courseData[2];
          success = true;
        });
      } catch (e) {
        print('Failed to load data: $e');
        retryCount++;
        if (retryCount >= maxRetries) {
          setState(() {
            errorMessage = 'Failed to load data after $maxRetries attempts';
          });
        }
      } finally {
        setState(() {
          isLoadingOne = false;
          isLoadingTwo = false;
          isLoadingThree = false;
        });
      }
    }
  }

  void _selectCourse(int course, ResultCourse courseDetail) {
    setState(() {
      selectedCourse = course;
      selectedCourseDetail = courseDetail;
    });
  }

  Widget _buildErrorMessage() {
    return errorMessage.isNotEmpty
        ? Center(child: Text(errorMessage, style: TextStyle(color: Colors.red)))
        : Container();
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 150,
            height: 150,
            child: Image.asset(
              'assets/images/bedrock_loading.gif',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: SizedBox(
              height: 90,
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    '베드락은 AWS의 똑똑한 생성형 AI',
                    textStyle: const TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 200),
                  ),
                  TypewriterAnimatedText(
                    '베드락이 사람처럼 생각하는 중',
                    textStyle: const TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 200),
                  ),
                  TypewriterAnimatedText(
                    "베드락은 '나쁜 돌'이 아닌 '기반암'",
                    textStyle: const TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 200),
                  ),
                ],
                repeatForever: true,
                pause: const Duration(milliseconds: 1000),
                displayFullTextOnTap: true,
                stopPauseOnTap: false,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseList(List<ResultCourse> courseDetails, String title,
      bool isLoading, int courseNumber) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobileView = constraints.maxWidth < 800;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
            SizedBox(height: 8),
            Container(
              height: isMobileView
                  ? 400
                  : (courseDetails.length * 100.0)
                      .clamp(200.0, double.infinity),
              child: isLoading
                  ? _buildLoadingIndicator()
                  : (courseDetails.isEmpty
                      ? Center(child: Text('No data'))
                      : (isMobileView
                          ? CarouselSlider(
                              options: CarouselOptions(
                                height: 400,
                                enlargeCenterPage: true,
                                enableInfiniteScroll: false,
                                initialPage: 0,
                                viewportFraction: 0.6,
                              ),
                              items: courseDetails
                                  .map((detail) => CourseDetailCard(
                                        detail: detail,
                                        courseNumber: courseNumber,
                                        isSelected:
                                            selectedCourse == courseNumber,
                                        onSelectCourse: (course) =>
                                            _selectCourse(course, detail),
                                      ))
                                  .toList(),
                            )
                          : Center(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: courseDetails
                                      .map((detail) => CourseDetailCard(
                                            detail: detail,
                                            courseNumber: courseNumber,
                                            isSelected:
                                                selectedCourse == courseNumber,
                                            onSelectCourse: (course) =>
                                                _selectCourse(course, detail),
                                          ))
                                      .toList(),
                                ),
                              ),
                            ))),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveSelectedCourse() async {
    List<ResultCourse>? selectedCourseDetails;

    if (selectedCourse == 1) {
      selectedCourseDetails = courseDetailsOne;
    } else if (selectedCourse == 2) {
      selectedCourseDetails = courseDetailsTwo;
    } else if (selectedCourse == 3) {
      selectedCourseDetails = courseDetailsThree;
    }

    if (selectedCourseDetails != null && selectedCourseDetails.isNotEmpty) {
      final courseRunAndSave = CourseRunAndSaveModel(
        memberId: subID.value,
        gu: sharedData.value,
        course1: selectedCourseDetails[0].id,
        course2:
            selectedCourseDetails.length > 1 ? selectedCourseDetails[1].id : '',
        course3:
            selectedCourseDetails.length > 2 ? selectedCourseDetails[2].id : '',
      );

      try {
        await insertCourseRunAndSave(courseRunAndSave);
        context.go('/main/real');
        isCreateCourse.value = true;
      } catch (e) {
        setState(() {
          errorMessage = 'Failed to save selected course';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI 추천 경로'),
        backgroundColor: const Color(0xFFFABC85),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 25),
              const TopOfApp(),
              const SizedBox(height: 50),
              _buildCourseList(courseDetailsOne, param1.value, isLoadingOne, 1),
              Divider(),
              _buildCourseList(courseDetailsTwo, param2.value, isLoadingTwo, 2),
              Divider(),
              _buildCourseList(
                  courseDetailsThree, param3.value, isLoadingThree, 3),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 800,
                  child: ElevatedButton(
                    onPressed: selectedCourse != 0 ? _saveSelectedCourse : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          selectedCourse != 0 ? Color(0xFFFABC85) : Colors.grey,
                      padding: EdgeInsets.symmetric(vertical: 20),
                    ),
                    child: Text(
                      '코스 실행',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              _buildErrorMessage(),
            ],
          ),
        ),
      ),
    );
  }
}

class TopOfApp extends StatelessWidget {
  const TopOfApp();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '원하시는 코스를 선택해 주세요!',
        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class CourseDetailCard extends StatelessWidget {
  final ResultCourse detail;
  final int courseNumber;
  final bool isSelected;
  final ValueChanged<int> onSelectCourse;

  CourseDetailCard({
    required this.detail,
    required this.courseNumber,
    required this.isSelected,
    required this.onSelectCourse,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelectCourse(courseNumber);
      },
      child: Container(
        width: 250,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange[100] : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: detail.imageUrl != null && detail.imageUrl!.isNotEmpty
                  ? Image.network(
                      detail.imageUrl!,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Icon(Icons.error);
                      },
                    )
                  : Container(
                      height: 150,
                      width: double.infinity,
                      color: Colors.grey[200],
                      child: Icon(
                        Icons.image,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                detail.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('주소: ${detail.address}'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('카테고리: ${detail.category}'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('평점: ${detail.budget}'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('예상 소요 시간: ${detail.time} 분'),
            )
          ],
        ),
      ),
    );
  }
}
