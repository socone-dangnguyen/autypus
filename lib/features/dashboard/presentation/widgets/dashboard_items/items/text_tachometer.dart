import 'package:flutter/material.dart';

class TextTachometer extends StatelessWidget {
  final double value;
  const TextTachometer({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "${value} x1000 rpm",
        style: TextStyle(
          fontSize: 30,
          color: Colors.white,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
