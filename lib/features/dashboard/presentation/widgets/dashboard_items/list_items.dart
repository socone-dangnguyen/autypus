import 'package:autypus/features/dashboard/presentation/widgets/dashboard_items/items/driving_mode.dart';
import 'package:autypus/features/dashboard/presentation/widgets/dashboard_items/items/light_direction.dart';
import 'package:autypus/features/dashboard/presentation/widgets/dashboard_items/items/odometer.dart';
import 'package:autypus/features/dashboard/presentation/widgets/dashboard_items/items/speedometer.dart';
import 'package:autypus/features/dashboard/presentation/widgets/dashboard_items/items/tachometer.dart';
import 'package:autypus/features/dashboard/presentation/widgets/dashboard_items/items/temperature_outside.dart';
import 'package:autypus/features/dashboard/presentation/widgets/dashboard_items/items/text_speedometer.dart';
import 'package:autypus/features/dashboard/presentation/widgets/dashboard_items/items/text_tachometer.dart';
import 'package:autypus/features/dashboard/presentation/widgets/dashboard_items/items/time.dart';
import 'package:autypus/features/dashboard/presentation/widgets/dashboard_items/items/turn_indicator.dart';
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
    },
    'Time': {
      'icon': Icon(
        Icons.access_time,
        color: Colors.white,
        size: 27,
      ),
      'container': Time(time: '00:00')
    },
    'Temperature Outside': {
      'icon': Icon(
        Icons.ac_unit,
        color: Colors.white,
        size: 27,
      ),
      'container': TemperatureOutside(value: 0)
    },
    'Driving Mode': {
      'icon': Icon(Icons.drive_eta, color: Colors.white, size: 27),
      'container': DrivingMode(
        mode: '',
      )
    },
    'Odometer': {
      'icon': Icon(Icons.speed, color: Colors.white, size: 27),
      'container': Odometer(value: 0),
    },
    'Turn Direction': {
      'icon': Icon(Icons.turn_right, color: Colors.white, size: 27),
      'container': TurnIndicator(
        direction: '',
      )
    },
    'Light Direction': {
      'icon': Icon(Icons.light_mode, color: Colors.white, size: 27),
      'container': LightDirection(direction: ''),
    },
  };
}
