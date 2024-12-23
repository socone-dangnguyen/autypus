import 'package:autypus/configs/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_box_transform/flutter_box_transform.dart';
import 'package:flutter_svg/svg.dart';

class TurnIndicator extends StatelessWidget {
  final String direction;
  const TurnIndicator({super.key, required this.direction});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.grey.shade700, shape: BoxShape.circle),
          child: SvgPicture.asset(
            'assets/icons/left_indicator.svg',
            color: direction == 'L'
                ? AppColors.primary100Color
                : Colors.grey.shade500,
            width: 20,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.grey.shade700, shape: BoxShape.circle),
          child: SvgPicture.asset(
            'assets/icons/right_indicator.svg',
            color: direction == 'R'
                ? AppColors.primary100Color
                : Colors.grey.shade500,
            width: 20,
          ),
        )
      ],
    );
  }
}
