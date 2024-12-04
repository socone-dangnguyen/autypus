import 'dart:math';

import 'package:autypus/configs/themes/app_colors.dart';
import 'package:autypus/core/utils/utils.dart';
import 'package:autypus/features/dashboard/presentation/widgets/dashboard_items/circle_meter.dart';
import 'package:autypus/features/dashboard/presentation/widgets/painter/circle.dart';
import 'package:flutter/material.dart';

class Speedometer extends StatefulWidget {
  const Speedometer({super.key, required this.value});
  final double value;

  @override
  State<Speedometer> createState() => _SpeedometerState();
}

class _SpeedometerState extends State<Speedometer>
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
  void didUpdateWidget(covariant Speedometer oldWidget) {
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
          return CircleMeter(
              value: anim.value,
              maxValue: 240,
              label: 'km/h',
              numberDivisions: 12);
        },
      ),
    );
  }
}
