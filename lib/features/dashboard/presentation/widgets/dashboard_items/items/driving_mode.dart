import 'package:autypus/configs/themes/app_colors.dart';
import 'package:flutter/material.dart';

class DrivingMode extends StatelessWidget {
  final String mode;
  const DrivingMode({super.key, required this.mode});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.symmetric(
            vertical: BorderSide(
              width: 2,
              color: AppColors.primary100Color,
            ),
          ),
        ),
        child: Text(
          mode,
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }
}
