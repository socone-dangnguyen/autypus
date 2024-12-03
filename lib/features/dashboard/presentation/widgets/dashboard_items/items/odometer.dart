import 'package:flutter/material.dart';

class Odometer extends StatelessWidget {
  final int value;
  const Odometer({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        child: Text(
          "ODO ${value}km",
          style: const TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.white,
            fontSize: 26,
          ),
        ),
      ),
    );
  }
}
