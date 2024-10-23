import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// CongestionBar 클래스는 혼잡도에 따라 색상이 변하는 바를 생성
class CongestionBar extends StatelessWidget {
  final String congestion;

  const CongestionBar({
    Key? key,
    required this.congestion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color barColor;
    switch (congestion) {
      case '붐빔':
        barColor = Colors.red;
        break;
      case '약간 붐빔':
        barColor = Colors.orange;
        break;
      case '보통':
        barColor = Colors.yellow;
        break;
      case '여유':
        barColor = Colors.green;
        break;
      default:
        barColor = Colors.grey;
        break;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1.0),
      height: 20.0,
      color: barColor,
    );
  }
}

// CourseItem 클래스는 코스 정보를 표시하는 위젯
class CourseItem extends StatelessWidget {
  final String title;
  final String address;
  final String congestion;

  const CourseItem({
    Key? key,
    required this.title,
    required this.address,
    required this.congestion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color barColor;
    switch (congestion) {
      case '붐빔':
        barColor = Colors.red;
        break;
      case '약간 붐빔':
        barColor = Colors.orange;
        break;
      case '보통':
        barColor = Colors.yellow;
        break;
      case '여유':
        barColor = Colors.green;
        break;
      default:
        barColor = Colors.grey;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text('주소: $address'),
          const SizedBox(height: 4),
          Text('혼잡도: $congestion'),
          const SizedBox(height: 8),
          Container(
            height: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: barColor,
            ),
          ),
        ],
      ),
    );
  }
}

// RouteButton 클래스는 "코스 생성" 버튼을 생성
class RouteButton extends StatelessWidget {
  final double width;
  final double height;

  const RouteButton({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: () => context.go('/main/real'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFABC85),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: const Text(
          '코스 생성',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
