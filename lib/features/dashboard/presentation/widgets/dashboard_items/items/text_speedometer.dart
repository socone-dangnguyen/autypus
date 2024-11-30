import 'package:flutter/material.dart';

class TextSpeedometer extends StatelessWidget {
  final double value;
  const TextSpeedometer({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "${value} km/h",
        style: TextStyle(
            fontSize: 50, fontStyle: FontStyle.italic, color: Colors.white),
      ),
    );
  }
}
