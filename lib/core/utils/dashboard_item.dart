import 'package:autypus/features/dashboard/domain/models/car_data_model.dart';
import 'package:autypus/features/dashboard/presentation/widgets/dashboard_items/items/speedometer.dart';
import 'package:autypus/features/dashboard/presentation/widgets/dashboard_items/items/tachometer.dart';
import 'package:autypus/features/dashboard/presentation/widgets/dashboard_items/items/text_speedometer.dart';
import 'package:autypus/features/dashboard/presentation/widgets/dashboard_items/items/text_tachometer.dart';
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
      default:
        copyWidget = inputWidget;
    }
    return copyWidget;
  }
}
