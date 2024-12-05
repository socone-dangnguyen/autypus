import 'package:flutter/material.dart';

class DashlinePainter extends CustomPainter {
  final double value;
  final double maxValue;
  final String startLabel;
  final String endLabel;
  final int numberDivisions;
  DashlinePainter({
    required this.value,
    required this.maxValue,
    required this.startLabel,
    required this.endLabel,
    required this.numberDivisions,
  });
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class DashlineMeter extends StatefulWidget {
  final double value;
  final double maxValue;
  final String startLabel;
  final String endLabel;
  final int numberDivisions;
  const DashlineMeter({
    super.key,
    required this.value,
    required this.maxValue,
    required this.startLabel,
    required this.endLabel,
    required this.numberDivisions,
  });

  @override
  State<DashlineMeter> createState() => _DashlineMeterState();
}

class _DashlineMeterState extends State<DashlineMeter>
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
  void didUpdateWidget(covariant DashlineMeter oldWidget) {
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
            painter: DashlinePainter(
              value: anim.value,
              maxValue: widget.maxValue,
              startLabel: widget.startLabel,
              endLabel: widget.endLabel,
              numberDivisions: widget.numberDivisions,
            ),
          );
        },
      ),
    );
  }
}
