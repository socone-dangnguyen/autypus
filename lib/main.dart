import 'package:autypus/features/dashboard/presentation/views/battery_chart.dart';
import 'package:autypus/features/dashboard/presentation/views/battery_line_chart.dart';
import 'package:autypus/features/dashboard/presentation/views/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LineChartSample2(),
    );
  }
}
