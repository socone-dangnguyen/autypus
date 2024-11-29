import 'dart:math';

import 'package:autypus/configs/themes/app_colors.dart';
import 'package:autypus/core/utils/utils.dart';
import 'package:flutter/material.dart';

class LinePainter extends CustomPainter {
  final Offset startPoint;
  final double angle; // Angle in radians
  final double length;

  LinePainter(
      {required this.startPoint, required this.angle, required this.length});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColors.primary100Color.withOpacity(0.2)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Tính toán điểm kết thúc dựa trên điểm bắt đầu, góc và độ dài
    double endX =
        startPoint.dx + length * cos(GeometryUtils.degreeToRadian(angle));
    double endY =
        startPoint.dy + length * sin(GeometryUtils.degreeToRadian(angle));

    // Vẽ đường thẳng
    canvas.drawLine(startPoint, Offset(endX, endY), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
