import 'dart:ui';
import 'package:autypus/configs/themes/app_colors.dart';
import 'package:autypus/core/utils/utils.dart';
import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  final Offset center; // Trung tâm của hình tròn
  final double radius; // Bán kính của hình tròn
  final double startAngle; // Góc bắt đầu (tính từ trục X)
  final double endAngle; // Góc kết thúc (tính từ trục X)
  final isClockWise;
  final Color color;
  CirclePainter(
      {required this.center,
      required this.radius,
      required this.startAngle,
      required this.endAngle,
      this.isClockWise = true,
      this.color = AppColors.primary100Color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Chuyển góc từ độ sang radian
    double startRadian = GeometryUtils.degreeToRadian(startAngle);
    double endRadian = GeometryUtils.degreeToRadian(endAngle);

    // Tính toán góc quét (sweepAngle)
    double sweepAngle = endRadian - startRadian;

    // Vẽ một phần của hình tròn (arc)
    Rect rect = Rect.fromCircle(center: center, radius: radius);
    if (isClockWise) {
      canvas.drawArc(rect, startRadian, sweepAngle, false, paint);
    } else {
      canvas.drawArc(rect, startRadian, -1 * sweepAngle, false, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
