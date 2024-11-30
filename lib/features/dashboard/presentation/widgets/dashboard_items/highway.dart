import 'package:autypus/features/dashboard/presentation/widgets/painter/dash_line.dart';
import 'package:autypus/features/dashboard/presentation/widgets/painter/draw_line.dart';
import 'package:autypus/features/dashboard/presentation/widgets/painter/trapezoid.dart';
import 'package:flutter/material.dart';

class HighwayLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double w = 150;
    double dy = 150;
    TrapezoidPainter(
      startPoint: Offset((size.width / 2) + w / 2, dy + 50),
      w: w,
      angle: 70,
    ).paint(canvas, size);
    DashLine(
            length: size.height,
            angle: 90,
            startPoint: Offset(size.width / 2, dy + 50))
        .paint(canvas, size);
    LinePainter(startPoint: Offset(0, dy), angle: 0, length: size.width)
        .paint(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

class Highway extends StatelessWidget {
  Highway({super.key});
  late final Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return CustomPaint(
      size: Size(double.infinity, double.infinity), // Kích thước canvas
      painter: HighwayLinePainter(),
    );
  }
}
