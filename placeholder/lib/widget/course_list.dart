import 'package:flutter/material.dart';

class CourseItem extends StatelessWidget {
  final String title;
  final String address;
  final String budget;
  final String congestion;
  final String time;
  final String imageUrl;

  const CourseItem({
    super.key,
    required this.title,
    required this.address,
    required this.budget,
    required this.congestion,
    required this.time,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return buildRowLayout();
        } else {
          return buildColumnLayout();
        }
      },
    );
  }

  Widget buildRowLayout() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            imageUrl,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTextColumn(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildColumnLayout() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            imageUrl,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20),
          buildTextColumn(),
        ],
      ),
    );
  }

  Widget buildTextColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: getCongestionColor(congestion),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                congestion,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          '주소: $address',
          style: TextStyle(
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '평점: $budget',
          style: TextStyle(
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '소요 시간: $time 분',
          style: TextStyle(
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Color getCongestionColor(String congestion) {
    switch (congestion) {
      case '여유':
        return Colors.green;
      case '보통':
        return Colors.yellow;
      case '약간 붐빔':
        return Colors.orange;
      case '붐빔':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
