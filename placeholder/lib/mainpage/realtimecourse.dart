import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:placeholder/globals.dart';
import 'package:placeholder/provider.dart';
import 'package:placeholder/services/api.dart';
import 'package:placeholder/services/model.dart';
import 'package:placeholder/widget/congestion_bar.dart';
import 'package:placeholder/widget/course_list.dart';
import 'package:placeholder/widget/test.dart';
import 'package:provider/provider.dart';

class RealTimeCoursePage extends StatefulWidget {
  const RealTimeCoursePage({super.key});

  @override
  State<RealTimeCoursePage> createState() => _RealTimeCoursePageState();
}

class _RealTimeCoursePageState extends State<RealTimeCoursePage> {
  late Future<List<MemberCourse>> futureMemberCourses;
  bool showMapScreen = false;

  double course1X = 0;
  double course1Y = 0;
  double course2X = 0;
  double course2Y = 0;
  double course3X = 0;
  double course3Y = 0;

  @override
  void initState() {
    super.initState();
    _fetchCourses();
  }

  void _fetchCourses() {
    futureMemberCourses = fetchRealTimeCourses(subID.value);
  }

  Future<void> stopCourse() async {
    try {
      await stopRealTimeCourse(subID.value);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Course stopped successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to stop course: $e')),
        );
      }
    }
  }

  int getStayTimeFlex(String stayTime) {
    return int.tryParse(stayTime) ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double imageSize = screenWidth * 0.15;

    return ChangeNotifierProvider(
      create: (context) => CourseLocationXY(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('${userName.value}의 실시간 코스입니다.'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.power_settings_new,
                  color: Colors.red, size: 30),
              onPressed: () {
                context.go('/main');
                stopCourse();
                isCreateCourse.value = false;
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    constraints: const BoxConstraints(
                      maxWidth: 100,
                      maxHeight: 100,
                    ),
                    child: Image.asset(
                      'assets/images/R_placeholder_elephant.png',
                      width: imageSize,
                      height: imageSize,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<List<MemberCourse>>(
                      future: futureMemberCourses,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          final courses = snapshot.data!;
                          return Row(
                            children: courses.map((course) {
                              return Expanded(
                                flex: getStayTimeFlex(course.time),
                                child: CongestionBar(
                                  congestion: course.congestion,
                                ),
                              );
                            }).toList(),
                          );
                        } else {
                          return const Center(child: Text('No data available'));
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.grey.shade200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('출발',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text('혼잡도',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              FutureBuilder<List<MemberCourse>>(
                future: futureMemberCourses,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final courses = snapshot.data!;
                    return Column(
                      children: courses.asMap().entries.map((entry) {
                        int index = entry.key;
                        var course = entry.value;
                        final courseLocation = Provider.of<CourseLocationXY>(
                            context,
                            listen: false);

                        double mapX = double.tryParse(course.mapX) ?? 0.0;
                        double mapY = double.tryParse(course.mapY) ?? 0.0;

                        if (index == 0) {
                          course1X = mapX;
                          course1Y = mapY;
                          courseLocation.setCourse1(mapX, mapY);
                        } else if (index == 1) {
                          course2X = mapX;
                          course2Y = mapY;
                          courseLocation.setCourse2(mapX, mapY);
                        } else if (index == 2) {
                          course3X = mapX;
                          course3Y = mapY;
                          courseLocation.setCourse3(mapX, mapY);
                        }
                        print("map : x - ${mapX}, y - ${mapY}");

                        return CourseItem(
                          title: course.name,
                          address: course.address,
                          budget: course.budget,
                          congestion: course.congestion,
                          time: course.time,
                          imageUrl: course.imageUrl,
                        );
                      }).toList(),
                    );
                  } else {
                    return const Center(child: Text('No data available'));
                  }
                },
              ),
              Card(
                elevation: 5,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      showMapScreen = true;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    constraints: const BoxConstraints(minHeight: 50),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.map, color: Colors.blue, size: 30),
                        SizedBox(width: 10),
                        Text(
                          "지도 생성",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (showMapScreen) MapScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
