import 'package:flutter/material.dart';

class StrikethroughPainter extends CustomPainter {
  final Animation<double> animation; // Update the parameter type here

  StrikethroughPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    double strikeThroughWidth = size.width * animation.value;
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(strikeThroughWidth, size.height / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
