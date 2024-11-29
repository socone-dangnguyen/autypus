import 'dart:math';
import 'dart:ui';

import 'package:autypus/configs/themes/app_colors.dart';
import 'package:autypus/core/utils/utils.dart';
import 'package:flutter/material.dart';

class DashLine extends CustomPainter {
  final Offset startPoint;
  final double angle; // Angle in radians
  final double length;

  DashLine({
    required this.startPoint,
    required this.angle,
    required this.length,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColors.primary100Color
          .withOpacity(0.4) // Set color from your theme
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    double dashWidth = 80; // Width of each dash
    double dashSpace = 80; // Space between each dash

    // Calculate the total number of dashes that can fit along the line
    double currentLength = 0;
    while (currentLength < length) {
      double dashEndX = startPoint.dx +
          (currentLength + dashWidth) *
              cos(GeometryUtils.degreeToRadian(angle));
      double dashEndY = startPoint.dy +
          (currentLength + dashWidth) *
              sin(GeometryUtils.degreeToRadian(angle));

      // Draw the dash
      canvas.drawLine(
        Offset(
            startPoint.dx +
                currentLength * cos(GeometryUtils.degreeToRadian(angle)),
            startPoint.dy +
                currentLength * sin(GeometryUtils.degreeToRadian(angle))),
        Offset(dashEndX, dashEndY),
        paint,
      );

      // Update the current length by adding the length of the dash and the space
      currentLength += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
