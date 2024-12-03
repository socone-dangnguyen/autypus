import 'package:autypus/features/dashboard/domain/models/car_data_model.dart';
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

class DashboardItem {
  static Widget getCarInstance(Widget inputWidget, CarDataModel carDataModel) {
    Widget copyWidget;
    switch (inputWidget.runtimeType) {
      case Tachometer:
        copyWidget = Tachometer(value: carDataModel.tachometer.toDouble());
      case TextTachometer:
        copyWidget = TextTachometer(value: carDataModel.tachometer.toDouble());
      case Speedometer:
        copyWidget = Speedometer(value: carDataModel.speedometer.toDouble());
      case TextSpeedometer:
        copyWidget =
            TextSpeedometer(value: carDataModel.speedometer.toDouble());
      case Time:
        copyWidget = Time(time: carDataModel.clock);
      case DrivingMode:
        copyWidget = DrivingMode(mode: carDataModel.drivingMode);
      case TemperatureOutside:
        copyWidget = TemperatureOutside(value: carDataModel.temperatureOutside);
      case Odometer:
        copyWidget = Odometer(value: carDataModel.odometer.toInt());
      case TurnIndicator:
        copyWidget = TurnIndicator(direction: carDataModel.turnDirection);
      case LightDirection:
        copyWidget = LightDirection(direction: carDataModel.lightDirection);
      default:
        copyWidget = inputWidget;
    }
    return copyWidget;
  }
}
