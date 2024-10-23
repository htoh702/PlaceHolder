library placeholder.globals;

import 'package:flutter/material.dart';
import 'package:placeholder/services/model.dart';

ValueNotifier<String> sharedData = ValueNotifier<String>('서초구');
ValueNotifier<String> startAddress = ValueNotifier<String>('출발지를 입력하세요.');
ValueNotifier<HotPlace?> selectedPlace = ValueNotifier<HotPlace?>(null);
ValueNotifier<bool> parkingInfo = ValueNotifier<bool>(false);
ValueNotifier<bool> cctvInfo = ValueNotifier<bool>(false);
ValueNotifier<String> selectedCategory = ValueNotifier<String>('음식점');
ValueNotifier<int> courseCounter = ValueNotifier<int>(0);
ValueNotifier<String> budget = ValueNotifier<String>('');
ValueNotifier<bool> isCreateCourse = ValueNotifier<bool>(false);
ValueNotifier<bool> isDark = ValueNotifier<bool>(false);

ValueNotifier<String> subID = ValueNotifier<String>("115926934351365764927");
ValueNotifier<String> userName = ValueNotifier<String>("");
ValueNotifier<String> userEmail = ValueNotifier<String>("");

ValueNotifier<String> param1 = ValueNotifier<String>("");
ValueNotifier<String> param2 = ValueNotifier<String>("");
ValueNotifier<String> param3 = ValueNotifier<String>("");

ValueNotifier<double> startX = ValueNotifier<double>(127.019664878091);
ValueNotifier<double> startY = ValueNotifier<double>(37.5205041140782);
// ValueNotifier<double> course1X = ValueNotifier<double>(0);
// ValueNotifier<double> course1Y = ValueNotifier<double>(0);
// ValueNotifier<double> course2X = ValueNotifier<double>(0);
// ValueNotifier<double> course2Y = ValueNotifier<double>(0);
// ValueNotifier<double> course3X = ValueNotifier<double>(0);
// ValueNotifier<double> course3Y = ValueNotifier<double>(0);
