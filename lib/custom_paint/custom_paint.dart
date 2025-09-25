import 'package:flutter/material.dart';

class SmileyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;

    // Draw face circle
    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);

    // Eyes
    final eyePaint = Paint()..color = Colors.black;
    canvas.drawCircle(Offset(size.width * 0.35, size.height * 0.35), 10, eyePaint);
    canvas.drawCircle(Offset(size.width * 0.65, size.height * 0.35), 10, eyePaint);

    // Smile (arc)
    final smilePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;
    final smileRect = Rect.fromCircle(center: size.center(Offset(0, 20)), radius: 60);
    canvas.drawArc(smileRect, 0.1, 3.14 - 0.2, false, smilePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}