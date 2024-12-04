import 'dart:math';

import 'package:autypus/configs/themes/app_colors.dart';
import 'package:autypus/core/utils/utils.dart';
import 'package:autypus/features/dashboard/presentation/widgets/painter/circle.dart';
import 'package:flutter/material.dart';

class RectanglePainter extends CustomPainter {
  final List<Offset> points;
  final Color color;
  final double strokeWidth;
  final double length;
  RectanglePainter({
    required this.points,
    this.color = AppColors.primary100Color,
    this.strokeWidth = 2,
    required this.length,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    final path = Path()..addPolygon(points, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CircleMeterPainter extends CustomPainter {
  final double value;
  final double maxValue;
  final String label;
  final int numberDivisions;
  CircleMeterPainter({
    required this.numberDivisions,
    required this.value,
    required this.maxValue,
    required this.label,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width, size.height) / 2;
    final double endAngle = (value * 270 / maxValue) + 135;
    CirclePainter(
      center: center,
      radius: radius,
      startAngle: 135,
      endAngle: 405,
      strokeWidth: 1,
      isClockWise: true,
    ).paint(canvas, size);
    CirclePainter(
      center: center,
      radius: radius * 2 / 3,
      startAngle: 135,
      endAngle: 405,
      strokeWidth: 0.5,
      isClockWise: true,
    ).paint(canvas, size);
    CirclePainter(
      center: center,
      radius: radius * 1 / 2,
      startAngle: 135,
      endAngle: 405,
      strokeWidth: 0.8,
      isClockWise: true,
    ).paint(canvas, size);
    CirclePainter(
      center: center,
      radius: radius * 0.93,
      startAngle: 135,
      endAngle: endAngle,
      strokeWidth: 1,
      isClockWise: true,
      color: Colors.white,
    ).paint(canvas, size);
    final textPainter = TextPainter(
      text: TextSpan(
        text: value.toStringAsFixed(0),
        style: TextStyle(
          color: Colors.white,
          fontSize: radius / 4,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(
      canvas,
      Offset(center.dx - textPainter.width / 2,
          center.dy - radius / 10 - textPainter.height / 2),
    );
    final labelPainter = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          color: Colors.grey.shade500.withOpacity(0.5),
          fontSize: radius / 15,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    labelPainter.paint(
      canvas,
      Offset(center.dx - labelPainter.width / 2,
          center.dy + radius / 6 - labelPainter.height / 2),
    );
    Paint textBorderPaint = Paint()
      ..color = Colors.grey.shade400.withOpacity(0.3)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(center.dx - labelPainter.width - radius / 8,
          center.dy + radius / 8 - labelPainter.height / 2),
      Offset(center.dx + labelPainter.width / 2 + radius / 8,
          center.dy + radius / 8 - labelPainter.height / 2),
      textBorderPaint,
    );
    canvas.drawLine(
      Offset(center.dx + labelPainter.width + radius / 8,
          center.dy + radius / 8 - labelPainter.height / 2),
      Offset(center.dx + labelPainter.width / 2 + radius / 6,
          center.dy + radius / 8 - labelPainter.height / 2),
      textBorderPaint,
    );
    final highlights = List.generate(
        numberDivisions + 1, (index) => 135 + (270 * index / numberDivisions));

    final paintHighlight = Paint()
      ..color = AppColors.primary100Color.withOpacity(0.3)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    for (int i = 0; i < highlights.length; i++) {
      var angle = highlights[i];
      final start = GeometryUtils.calculatePoint(center, angle, radius);
      final end = GeometryUtils.calculatePoint(center, angle, radius * 0.95);
      canvas.drawLine(start, end, paintHighlight);
      final tp = TextPainter(
        text: TextSpan(
          text: "${maxValue / numberDivisions * i}",
          style: TextStyle(
              fontSize: radius / 15,
              color: Colors.white,
              fontFamily: 'Montserrat'),
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      final textOffset =
          GeometryUtils.calculatePoint(center, angle, radius * 0.85);
      final centered =
          Offset(textOffset.dx - tp.width / 2, textOffset.dy - tp.height / 2);
      tp.paint(canvas, centered);
    }
    final Offset startLine_1 = GeometryUtils.calculatePoint(
        center, (value * 270 / maxValue) + 134.5, radius * 2 / 3);
    final Offset startLine_2 = GeometryUtils.calculatePoint(
        center, (value * 270 / maxValue) + 135.5, radius * 2 / 3);
    final Offset endLine = GeometryUtils.calculatePoint(
        center, (value * 270 / maxValue) + 135, radius * 0.92);
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill; // Set the style to 'fill'
    final path = Path()
      ..addPolygon([
        startLine_1,
        startLine_2,
        endLine,
      ], true);
    canvas.drawPath(path, paint);
    for (double i = 135; i < endAngle - 1; i += 0.5) {
      final p1 = GeometryUtils.calculatePoint(center, i, radius * 0.92);
      final p2 = GeometryUtils.calculatePoint(center, i + 1, radius * 0.92);
      final p3 = GeometryUtils.calculatePoint(center, i, (radius * 2 / 3));
      final p4 = GeometryUtils.calculatePoint(center, i + 1, (radius * 2 / 3));
      final double opacity = (i - 135) / (endAngle - 135);
      RectanglePainter(
        points: [p1, p2, p4, p3],
        length: radius * 0.92 - (radius * 2 / 3),
        color: AppColors.primary100Color.withOpacity(opacity / 3),
      ).paint(canvas, size);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CircleMeter extends StatefulWidget {
  final double value;
  final double maxValue;
  final String label;
  final int numberDivisions;
  const CircleMeter(
      {super.key,
      required this.value,
      required this.maxValue,
      required this.label,
      required this.numberDivisions});

  @override
  State<CircleMeter> createState() => _CircleMeterState();
}

class _CircleMeterState extends State<CircleMeter>
    with SingleTickerProviderStateMixin {
  late AnimationController ctrl;
  late Animation<double> anim;
  @override
  void initState() {
    super.initState();

    ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    anim = Tween<double>(begin: 0, end: widget.value)
        .animate(CurvedAnimation(parent: ctrl, curve: Curves.easeOutCubic));
    ctrl.forward();
  }

  @override
  void didUpdateWidget(covariant CircleMeter oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Chỉ cập nhật khi giá trị speed thay đổi
    if (oldWidget.value != widget.value) {
      anim = Tween<double>(begin: anim.value, end: widget.value).animate(
        CurvedAnimation(parent: ctrl, curve: Curves.easeInOut),
      );
      ctrl.forward(from: 0);
    }
  }

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: AnimatedBuilder(
        animation: anim,
        builder: (context, child) {
          return CustomPaint(
            painter: CircleMeterPainter(
              value: anim.value,
              maxValue: widget.maxValue,
              label: widget.label,
              numberDivisions: widget.numberDivisions,
            ),
          );
        },
      ),
    );
  }
}
