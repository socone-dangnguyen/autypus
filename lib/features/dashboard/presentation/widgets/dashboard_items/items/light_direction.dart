import 'package:autypus/configs/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LightDirection extends StatelessWidget {
  final String direction;
  const LightDirection({super.key, required this.direction});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.grey.shade700, shape: BoxShape.circle),
          child: SvgPicture.asset(
            'assets/icons/dipper.svg',
            width: 25,
            color: direction == 'Down'
                ? AppColors.primary100Color
                : Colors.grey.shade400,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.grey.shade700, shape: BoxShape.circle),
          child: SvgPicture.asset(
            'assets/icons/head_light.svg',
            width: 25,
            color: direction == 'Top'
                ? AppColors.primary100Color
                : Colors.grey.shade400,
          ),
        )
      ],
    );
  }
}
