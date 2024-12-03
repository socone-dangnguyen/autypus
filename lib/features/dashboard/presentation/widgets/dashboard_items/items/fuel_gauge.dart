// import 'package:flutter/material.dart';

// class FuelGaugePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//      Paint paint = Paint()
//       ..color = Colors.blue
//       ..style = PaintingStyle.stroke // Vẽ viền
//       ..strokeWidth = 2.0
//       ..pathEffect = PathEffect.dashPath([5, 5], 0); // Định nghĩa đường nét đứt

//     // Vẽ hình tròn tại điểm (size.width/2, size.height/2) với bán kính bằng size.width/2
//     canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     // TODO: implement shouldRepaint
//     throw UnimplementedError();
//   }
// }

// class FuelGauge extends StatelessWidget {
//   const FuelGauge({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
