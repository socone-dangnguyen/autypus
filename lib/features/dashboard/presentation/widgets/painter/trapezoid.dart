import 'dart:math';
import 'dart:ui';

import 'package:autypus/configs/themes/app_colors.dart';
import 'package:autypus/core/utils/utils.dart';
import 'package:flutter/material.dart';

class TrapezoidPainter extends CustomPainter {
  final Offset startPoint;
  final double w;
  final double angle;

  const TrapezoidPainter({
    required this.startPoint,
    required this.w,
    required this.angle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    List<Offset> points = [startPoint];
    double h = size.height / sin(GeometryUtils.degreeToRadian(angle));
    Offset point_1 = GeometryUtils.calculatePoint(startPoint, 180, w);
    points.add(point_1);
    Offset point_2 = GeometryUtils.calculatePoint(startPoint, angle, h);
    Offset point_3 = GeometryUtils.calculatePoint(point_1, 180 - angle, h);

    points.add(point_3);
    points.add(point_2);

    // Tạo paint để tô màu cho hình thang
    final paint = Paint()
      ..color = AppColors.primary300Color
          .withOpacity(0.2) // Set the fill color to blue
      ..style = PaintingStyle.fill;

    final path = Path()..addPolygon(points, true);
    canvas.drawPath(path, paint);

    // Vẽ viền của hình thang
    final borderPaint = Paint()
      ..color =
          AppColors.primary100Color.withOpacity(0.3) // Đặt màu viền là màu đen
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0; // Đặt độ dày của viền

    canvas.drawLine(startPoint, point_2, borderPaint);
    canvas.drawLine(point_1, point_3, borderPaint);
  }

  // Hàm vẽ mờ dọc theo một đường thẳng
  void _drawBlurLine(Canvas canvas, Offset from, Offset to, Paint blurPaint) {
    const int numSegments = 15; // Số lượng phân đoạn trên đường thẳng

    // Chia đoạn đường thành các phân đoạn và vẽ các điểm mờ trên đó
    for (int i = 0; i <= numSegments; i++) {
      double t = i / numSegments;
      Offset point = Offset(
        from.dx + t * (to.dx - from.dx),
        from.dy + t * (to.dy - from.dy),
      );
      // Vẽ mờ tại các điểm trên đường thẳng
      canvas.drawCircle(
          point, 80.0, blurPaint); // Vẽ vòng tròn mờ với bán kính 8
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
