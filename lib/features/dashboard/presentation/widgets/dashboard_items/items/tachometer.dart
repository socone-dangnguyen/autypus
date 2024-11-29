import 'package:autypus/features/dashboard/presentation/widgets/painter/circle.dart';
import 'package:flutter/material.dart';

class TachometerPainter extends CustomPainter {
  final double value;
  final double maxValue = 10.0;
  TachometerPainter({required this.value});
  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(1400, 500);
    CirclePainter(
      center: center, // Tọa độ trung tâm của hình tròn
      radius: 300, // Bán kính
      startAngle: 90, // Góc bắt đầu (0 độ, tương ứng với trục X)
      endAngle: 320, //
      isClockWise: false,
    ).paint(canvas, size);
    CirclePainter(
      center: center, // Tọa độ trung tâm của hình tròn
      radius: 250, // Bán kính
      startAngle: 90, // Góc bắt đầu (0 độ, tương ứng với trục X)
      endAngle: 320, //
      isClockWise: false,
      color: Colors.white,
    ).paint(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
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
          return CustomPaint(painter: TachometerPainter(value: 6));
        },
      ),
    );
  }
}
