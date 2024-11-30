import 'package:autypus/configs/themes/app_colors.dart';
import 'package:autypus/core/utils/utils.dart';
import 'package:autypus/features/dashboard/presentation/widgets/painter/circle.dart';
import 'package:flutter/material.dart';

class TachometerPainter extends CustomPainter {
  final double value;
  final double maxValue = 10.0;
  TachometerPainter({required this.value});
  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(1400, 500);
    const double maxAngle = 320;
    const double radius = 300;
    CirclePainter(
      center: center, // Tọa độ trung tâm của hình tròn
      radius: radius, // Bán kính
      startAngle: 90, // Góc bắt đầu (0 độ, tương ứng với trục X)
      endAngle: maxAngle, //
      isClockWise: false,
    ).paint(canvas, size);

    CirclePainter(
      center: center, // Tọa độ trung tâm của hình tròn
      radius: radius - 30, // Bán kính
      startAngle: 90, // Góc bắt đầu (0 độ, tương ứng với trục X)
      endAngle: 90 + ((maxAngle - 90) * value / maxValue), //
      isClockWise: false,
      strokeWidth: 4,
      color: Colors.white,
    ).paint(canvas, size);
    final highlights = List.generate(maxValue.toInt() + 1,
        (index) => 90 - ((maxAngle - 90) * index / maxValue));
    final paintHighlight = Paint()
      ..color = AppColors.primary100Color.withOpacity(0.3)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    for (int i = 0; i < highlights.length; i++) {
      var angle = highlights[i];
      final start = GeometryUtils.calculatePoint(center, angle, radius);
      final end = GeometryUtils.calculatePoint(center, angle, radius * 0.85);
      canvas.drawLine(start, end, paintHighlight);
      final tp = TextPainter(
        text: TextSpan(
          text: "${i}",
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontFamily: 'Montserrat'),
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      final textOffset =
          GeometryUtils.calculatePoint(center, angle, radius * 0.75);
      final centered =
          Offset(textOffset.dx - tp.width / 2, textOffset.dy - tp.height / 2);
      tp.paint(canvas, centered);
    }
    Paint linePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
        center,
        GeometryUtils.calculatePoint(
            center, (90 - (maxAngle - 90) * value / maxValue), radius * 0.65),
        linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Tachometer extends StatefulWidget {
  const Tachometer({super.key, required this.value});
  final double value;

  @override
  State<Tachometer> createState() => _TachometerState();
}

class _TachometerState extends State<Tachometer>
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
  void didUpdateWidget(covariant Tachometer oldWidget) {
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
          return CustomPaint(painter: TachometerPainter(value: anim.value));
        },
      ),
    );
  }
}
