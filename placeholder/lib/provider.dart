import 'package:flutter/material.dart';

class CourseLocationXY with ChangeNotifier {
  double _startX = 0;
  double _startY = 0;
  double _course1X = 0;
  double _course1Y = 0;
  double _course2X = 0;
  double _course2Y = 0;
  double _course3X = 0;
  double _course3Y = 0;

  double get startX => _startX;
  double get startY => _startY;
  double get course1X => _course1X;
  double get course1Y => _course1Y;
  double get course2X => _course2X;
  double get course2Y => _course2Y;
  double get course3X => _course3X;
  double get course3Y => _course3Y;

  void setStart(double x, double y) {
    _startX = x;
    _startY = y;
    notifyListeners();
  }

  void setCourse1(double x, double y) {
    _course1X = x;
    _course1Y = y;
    notifyListeners();
  }

  void setCourse2(double x, double y) {
    _course2X = x;
    _course2Y = y;
    notifyListeners();
  }

  void setCourse3(double x, double y) {
    _course3X = x;
    _course3Y = y;
    notifyListeners();
  }
}

class UserData with ChangeNotifier {
  String _userId = '';
  String _email = '';
  String _name = '';

  String get userId => _userId;
  String get email => _email;
  String get name => _name;

  void setUserId(String id) {
    _userId = id;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setName(String name) {
    _name = name;
    notifyListeners();
  }
}