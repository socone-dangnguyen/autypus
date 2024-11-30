import 'package:autypus/features/dashboard/presentation/widgets/dashboard_items/items/speedometer.dart';
import 'package:autypus/features/dashboard/presentation/widgets/dashboard_items/items/tachometer.dart';
import 'package:autypus/features/dashboard/presentation/widgets/dashboard_items/items/text_speedometer.dart';
import 'package:autypus/features/dashboard/presentation/widgets/dashboard_items/items/text_tachometer.dart';
import 'package:flutter/material.dart';

class ListItems {
  static final Map<String, Map<String, Widget>> dashBoardItems = {
    'Tachometer': {
      'icon': Icon(Icons.speed_outlined, color: Colors.white, size: 27),
      'container': Tachometer(
        value: 0,
      )
    },
    'Text Tachometer': {
      'icon': Icon(Icons.speed_outlined, color: Colors.white, size: 27),
      'container': TextTachometer(
        value: 0,
      )
    },
    'Speedometer': {
      'icon': Icon(
        Icons.speed,
        color: Colors.white,
        size: 27,
      ),
      'container': Speedometer(value: 0),
    },
    'Text Speedometer': {
      'icon': Icon(
        Icons.speed,
        color: Colors.white,
        size: 27,
      ),
      'container': TextSpeedometer(value: 0),
    }
  };
}
