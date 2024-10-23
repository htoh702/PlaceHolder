import 'package:flutter/material.dart';
import '/chatbot/model/checkmodel.dart';
import '/chatbot/widget/checkwidget.dart';

class CreateCourseCheck extends StatefulWidget {
  const CreateCourseCheck({super.key});

  @override
  State<CreateCourseCheck> createState() => _CreateCourseCheckPageState();
}

class _CreateCourseCheckPageState extends State<CreateCourseCheck> {
  // 코스 정보를 담고 있는 Map
  final Map<String, Course> courseItems = {
    '코스 1': Course(
      address: '123 Main St',
      congestion: '붐빔',
    ),
    '코스 2': Course(
      address: '456 Elm St',
      congestion: '보통',
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('코스 확인'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(
              '모모동의 실시간 코스입니다.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            // 코스 정보와 이미지를 나란히 표시하는 Row
            Row(
              children: [
                Image.asset(
                  'assets/images/R_placeholder_elephant.png',
                  width: 100,
                  height: 100,
                ),
                Expanded(
                  child: Row(
                    children: courseItems.entries.map((entry) {
                      return Expanded(
                        child: CongestionBar(
                          congestion: entry.value.congestion,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // "출발" 및 "혼잡도"를 표시하는 Container
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.grey.shade200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    '출발',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '혼잡도',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // 코스 정보를 리스트로 표시하는 ListView
            Expanded(
              child: ListView(
                children: courseItems.entries.map((entry) {
                  return CourseItem(
                    title: entry.key,
                    address: entry.value.address,
                    congestion: entry.value.congestion,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      // 하단에 네비게이션 바 추가
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: SizedBox(
          height: 70,
          child: Center(
            child: RouteButton(
              width: 350,
              height: 50,
            ),
          ),
        ),
      ),
    );
  }
}
