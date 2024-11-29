import 'package:autypus/features/dashboard/presentation/widgets/painter/circle.dart';
import 'package:flutter/material.dart';

class Speedometer extends StatelessWidget {
  const Speedometer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          painter: CirclePainter(
            center: Offset(350, 300), // Tọa độ trung tâm của hình tròn
            radius: 300, // Bán kính
            startAngle: 90, // Góc bắt đầu (0 độ, tương ứng với trục X)
            endAngle: 320, //
          ),
        ),
        CustomPaint(
          painter: CirclePainter(
            center: Offset(350, 300), // Tọa độ trung tâm của hình tròn
            radius: 250, // Bán kính
            startAngle: 90, // Góc bắt đầu (0 độ, tương ứng với trục X)
            endAngle: 320, //
          ),
        ),
      ],
    );
  }
}
