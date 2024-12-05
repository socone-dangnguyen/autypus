import 'package:flutter/material.dart';

class DrivingModeModel extends ChangeNotifier {
  String key;
  DrivingModeModel({required this.key});
  void updateKey(String newKey) {
    key = newKey;
    notifyListeners();
  }
}
