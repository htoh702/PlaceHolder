import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alert Area Settings',
      theme: ThemeData(
        primaryColor: const Color(0xFFFABC85),
        scaffoldBackgroundColor: const Color(0xFFFFF5EE),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFABC85),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
        ),
        sliderTheme: SliderThemeData(
          activeTrackColor: const Color(0xFFFABC85),
          inactiveTrackColor:
              const Color(0xFFFABC85).withOpacity(0.3), // Modified
          thumbColor: const Color(0xFFFABC85),
          overlayColor: const Color(0xFFFABC85).withAlpha(32),
          valueIndicatorColor: const Color(0xFFFABC85),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFABC85),
            textStyle: const TextStyle(color: Colors.white),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black, fontSize: 16),
          bodyMedium: TextStyle(color: Colors.black54, fontSize: 14),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orangeAccent),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
          ),
          labelStyle: TextStyle(color: Colors.orange),
        ),
        listTileTheme: ListTileThemeData(
          tileColor: Colors.white,
          selectedTileColor: Colors.orange[100], // 수정된 부분
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
      home: const AlertAreaSettings(),
    );
  }
}

class AlertAreaSettings extends StatefulWidget {
  const AlertAreaSettings({Key? key}) : super(key: key);

  @override
  State<AlertAreaSettings> createState() => _AlertAreaSettingsState();
}

class _AlertAreaSettingsState extends State<AlertAreaSettings> {
  double _alertRangeValue = 2.0;
  final List<String> _alertAreas = [];
  final TextEditingController _textController = TextEditingController();

  void _addAlertArea() {
    if (_textController.text.isNotEmpty) {
      setState(() {
        _alertAreas.add(_textController.text);
        _textController.clear();
      });
    }
  }

  void _removeAlertArea(int index) {
    setState(() {
      _alertAreas.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('혼잡도 알림 지역 설정'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  '알림 혼잡도 범위',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Slider(
                    value: _alertRangeValue,
                    min: 0,
                    max: 4,
                    divisions: 4,
                    label: _getSliderLabel(_alertRangeValue),
                    onChanged: (value) {
                      setState(() {
                        _alertRangeValue = value;
                      });
                    },
                    activeColor: const Color(0xFFFABC85), // Custom active color
                    inactiveColor: const Color(0xFFFABC85)
                        .withOpacity(0.3), // Custom inactive color
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      labelText: '알림 지역',
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: _addAlertArea,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFFFABC85), // Custom button color
                  ),
                  child: Text(
                    '추가',
                    style: const TextStyle(
                      color: Colors.black, // Custom text color
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              '알림 지역 목록',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: _alertAreas.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      title: Text(_alertAreas[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () => _removeAlertArea(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getSliderLabel(double value) {
    switch (value.round()) {
      case 0:
        return '여유';
      case 1:
        return '보통';
      case 2:
        return '약간 붐빔';
      case 3:
        return '붐빔';
      default:
        return '';
    }
  }
}
