import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TemperatureOutside extends StatelessWidget {
  final double value;
  const TemperatureOutside({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        value.toString(),
        style: TextStyle(
            fontSize: 20, fontFamily: 'Montserrat', color: Colors.white),
      ),
      const SizedBox(
        width: 4,
      ),
      SvgPicture.asset(
        'assets/icons/celsius.svg',
        width: 20,
        color: Colors.white,
      )
    ]);
  }
}
