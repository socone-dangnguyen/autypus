import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:autypus/configs/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DashlinePainter extends CustomPainter {
  final double value;
  final String startLabel;
  final String endLabel;
  final int numberDivisions;
  final ui.Image? image; // Changed to ui.Image

  DashlinePainter({
    required this.value,
    required this.startLabel,
    required this.endLabel,
    required this.numberDivisions,
    this.image,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Center of the canvas
    Offset center = Offset(size.width / 2, size.height / 2);
    const double dashWidth = 10;
    const double dashSpace = 3;

    // Paint for the dashed line
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Draw dashed line
    double y = center.dy;

    for (int i = 0; i < numberDivisions; i++) {
      canvas.drawLine(
        Offset(center.dx + i * (dashWidth + dashSpace), y),
        Offset(center.dx + i * (dashWidth + dashSpace) + dashWidth, y),
        paint,
      );
    }

    // // Paint for the filled dashed line based on value
    // Paint paint2 = Paint()
    //   ..color = AppColors.primary100Color
    //   ..strokeWidth = 3
    //   ..style = PaintingStyle.stroke;

    // int filledDivisions = value.toInt().clamp(0, numberDivisions);
    // for (int i = 0; i < filledDivisions; i++) {
    //   canvas.drawLine(
    //     Offset(startX + i * (dashWidth + dashSpace), y),
    //     Offset(startX + i * (dashWidth + dashSpace) + dashWidth, y),
    //     paint2,
    //   );
    // }

    // Draw start label
    TextPainter textPainterStart = TextPainter(
      text: TextSpan(
        text: startLabel,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainterStart.layout();
    textPainterStart.paint(
      canvas,
      Offset(center.dx - 15, y - 8),
    );

    // Draw end label
    TextPainter textPainterEnd = TextPainter(
      text: TextSpan(
        text: endLabel,
        style: TextStyle(
          color: AppColors.primary100Color,
          fontSize: 14,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainterEnd.layout();
    // textPainterEnd.paint(
    //   canvas,
    //   Offset(center.dx+numberDivisions*(), y - 8),
    // );

    // Draw image if available, positioned above the dashed line
    if (image != null) {
      double imgWidth = 40;
      double imgHeight = 40;
      Offset imgOffset = Offset(center.dx, center.dy);
      Paint imagePaint = Paint()
        ..colorFilter = ColorFilter.mode(Colors.white, BlendMode.srcIn);

      canvas.drawImageRect(
        image!,
        Rect.fromLTWH(0, 0, image!.width.toDouble(), image!.height.toDouble()),
        Rect.fromCenter(
            center: Offset(center.dx - 40, center.dy - imgHeight / 2 + 15),
            width: imgWidth,
            height: imgHeight),
        imagePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant DashlinePainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.startLabel != startLabel ||
        oldDelegate.endLabel != endLabel ||
        oldDelegate.numberDivisions != numberDivisions ||
        oldDelegate.image != image;
  }
}

class DashlineMeter extends StatefulWidget {
  final double value;
  final String startLabel;
  final String endLabel;
  final int numberDivisions;
  final String? iconPath; // Path to the image asset

  const DashlineMeter({
    Key? key,
    required this.value,
    required this.startLabel,
    required this.endLabel,
    required this.numberDivisions,
    this.iconPath,
  }) : super(key: key);

  @override
  State<DashlineMeter> createState() => _DashlineMeterState();
}

class _DashlineMeterState extends State<DashlineMeter>
    with SingleTickerProviderStateMixin {
  late AnimationController ctrl;
  late Animation<double> anim;
  ui.Image? _image; // To hold the loaded image

  @override
  void initState() {
    super.initState();
    ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    anim = Tween<double>(begin: 0, end: widget.value).animate(
      CurvedAnimation(parent: ctrl, curve: Curves.easeOutCubic),
    )..addListener(() {
        setState(() {}); // Rebuild to reflect animation
      });
    ctrl.forward();

    if (widget.iconPath != null) {
      _loadImage(widget.iconPath!);
    }
  }

  @override
  void didUpdateWidget(covariant DashlineMeter oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value != widget.value) {
      anim = Tween<double>(begin: anim.value, end: widget.value).animate(
        CurvedAnimation(parent: ctrl, curve: Curves.easeInOut),
      )..addListener(() {
          setState(() {});
        });
      ctrl.forward(from: 0);
    }

    if (oldWidget.iconPath != widget.iconPath && widget.iconPath != null) {
      _loadImage(widget.iconPath!);
    }
  }

  Future<void> _loadImage(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    final Uint8List bytes = data.buffer.asUint8List();
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(bytes, (ui.Image img) {
      completer.complete(img);
    });
    final ui.Image img = await completer.future;
    setState(() {
      _image = img;
    });
  }

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Use infinity to take up all available width
      height: 100, // Set a fixed height for the painter
      child: CustomPaint(
        painter: DashlinePainter(
          value: anim.value,
          startLabel: widget.startLabel,
          endLabel: widget.endLabel,
          numberDivisions: widget.numberDivisions,
          image: _image, // Pass the loaded image
        ),
      ),
    );
  }
}
