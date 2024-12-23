import 'dart:async';
import 'dart:math';

import 'package:autypus/configs/themes/app_colors.dart'; // Ensure this path is correct
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({super.key});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    AppColors.primary100Color,
    AppColors.primary300Color,
  ];

  bool showAvg = false;

  // Data points for the chart
  List<FlSpot> batteryData = [];
  double timeElapsed = 0;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Initialize with some data
    batteryData = [
      FlSpot(0, 50),
    ];

    // Start the timer to update data every second
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        timeElapsed += 1;
        // Simulate battery level changes
        double newBatteryLevel = (batteryData.last.y +
                (Random().nextDouble() * 2 -
                    1)) // Random change between -1 and +1
            .clamp(0.0, 100.0);
        batteryData.add(FlSpot(timeElapsed, newBatteryLevel));

        // Keep only the last 60 data points (last 60 seconds)
        if (batteryData.length > 60) {
          batteryData.removeAt(0);
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when disposing
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              left: 12,
              top: 24,
              bottom: 12,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: max(
                    300,
                    batteryData.length *
                        20.0), // Adjust width based on data points
                child: LineChart(
                  showAvg ? avgData() : mainData(),
                  // Optional animation
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: SizedBox(
            width: 60,
            height: 34,
            child: TextButton(
              onPressed: () {
                setState(() {
                  showAvg = !showAvg;
                });
              },
              child: Text(
                'avg',
                style: TextStyle(
                  fontSize: 12,
                  color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor:
                    showAvg ? Colors.black.withOpacity(0.5) : Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Main data for live updating chart
  LineChartData mainData() {
    return LineChartData(
      minY: 0,
      maxY: 100,
      minX: batteryData.isNotEmpty ? batteryData.first.x : 0,
      maxX: batteryData.isNotEmpty ? batteryData.last.x : 60,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 20,
        verticalInterval: 10,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: AppColors.blackColor.withOpacity(0.2),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: AppColors.blackColor.withOpacity(0.2),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 10,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 20,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d), width: 1),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: batteryData,
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
      lineTouchData: LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              return LineTooltipItem(
                '${barSpot.y.toStringAsFixed(2)}%',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              );
            }).toList();
          },
        ),
      ),
    );
  }

  // Average data (optional, can be customized)
  LineChartData avgData() {
    double avg = batteryData.isNotEmpty
        ? batteryData.map((spot) => spot.y).reduce((a, b) => a + b) /
            batteryData.length
        : 0;

    return LineChartData(
      minY: 0,
      maxY: 100,
      minX: batteryData.isNotEmpty ? batteryData.first.x : 0,
      maxX: batteryData.isNotEmpty ? batteryData.last.x : 60,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 20,
        verticalInterval: 10,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: AppColors.blackColor.withOpacity(0.2),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: AppColors.blackColor.withOpacity(0.2),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 10,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 20,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d), width: 1),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: batteryData,
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              AppColors.primary100Color.withOpacity(0.5),
              AppColors.primary300Color.withOpacity(0.5),
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                AppColors.primary100Color.withOpacity(0.1),
                AppColors.primary300Color.withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
      lineTouchData: LineTouchData(
        enabled: false,
      ),
    );
  }

  // Custom left titles
  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
      color: Colors.black,
    );
    String text;
    if (value == 0) {
      text = '0%';
    } else if (value == 20) {
      text = '20%';
    } else if (value == 40) {
      text = '40%';
    } else if (value == 60) {
      text = '60%';
    } else if (value == 80) {
      text = '80%';
    } else if (value == 100) {
      text = '100%';
    } else {
      return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  // Custom bottom titles
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
      color: Colors.black,
    );
    Widget text;
    // Display labels every 10 seconds
    if (value % 10 == 0) {
      text = Text('${value.toInt()}s', style: style);
    } else {
      text = const Text('');
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8,
      child: text,
    );
  }
}
