import 'package:flutter/material.dart';

class Time extends StatelessWidget {
  final String time;
  const Time({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        time,
        style: TextStyle(
          fontStyle: FontStyle.italic,
          fontSize: 20,
          fontFamily: 'Montserrat',
          color: Colors.white,
        ),
      ),
    );
  }
}
