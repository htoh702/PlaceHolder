import 'package:flutter/material.dart';
import 'package:placeholder/globals.dart' as globals;

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  @override
  void initState() {
    super.initState();
    globals.selectedCategory.addListener(_updateState);
    globals.parkingInfo.addListener(_updateState);
    globals.cctvInfo.addListener(_updateState);
  }

  @override
  void dispose() {
    globals.selectedCategory.removeListener(_updateState);
    globals.parkingInfo.removeListener(_updateState);
    globals.cctvInfo.removeListener(_updateState);
    super.dispose();
  }

  void _updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '보기 옵션',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 10),
          const Text('카테고리'),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCategoryButton('음식점'),
              _buildCategoryButton('카페'),
              _buildCategoryButton('놀거리'),
            ],
          ),
          const SizedBox(height: 20),
          const Text('주차 정보'),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildToggleButton('On', globals.parkingInfo.value, () {
                globals.parkingInfo.value = true;
              }),
              _buildToggleButton('Off', !globals.parkingInfo.value, () {
                globals.parkingInfo.value = false;
              }),
            ],
          ),
          const SizedBox(height: 20),
          const Text('CCTV 로드뷰'),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildToggleButton('On', globals.cctvInfo.value, () {
                globals.cctvInfo.value = true;
              }),
              _buildToggleButton('Off', !globals.cctvInfo.value, () {
                globals.cctvInfo.value = false;
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(String category) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          globals.selectedCategory.value = category;
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: globals.selectedCategory.value == category
                ? Colors.grey
                : Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              category,
              style: TextStyle(
                color: globals.selectedCategory.value == category
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton(
      String label, bool isActive, VoidCallback onPressed) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: isActive ? Colors.grey : Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
