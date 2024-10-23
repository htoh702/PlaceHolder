import 'package:flutter/material.dart';

class TopOfApp extends StatelessWidget {
  const TopOfApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Row(
        children: [
          const SizedBox(width: 10),
          SizedBox(
            width: 50,
            height: 50,
            child: Image.asset('assets/images/placeholder_elephant.png',
                fit: BoxFit.contain),
          ),
          const SizedBox(width: 5),
          SizedBox(
            width: 200,
            height: 50,
            child: Image.asset('assets/images/placeholder_name.png',
                fit: BoxFit.contain),
          ),
        ],
      ),
    );
  }
}
