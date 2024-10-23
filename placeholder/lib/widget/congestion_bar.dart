import 'package:flutter/material.dart';

class CongestionBar extends StatelessWidget {
  final String congestion;

  const CongestionBar({
    super.key,
    required this.congestion,
  });

  @override
  Widget build(BuildContext context) {
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

    return Container(
      height: 20,
      decoration: BoxDecoration(
        color: getCongestionColor(congestion),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
