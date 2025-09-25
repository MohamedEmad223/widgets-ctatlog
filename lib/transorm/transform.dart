import 'package:flutter/material.dart';
import 'dart:math' as math;

class SkewedBanner extends StatelessWidget {
  const SkewedBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black,
      child: Transform(
        transform: Matrix4.skewY(0.3)..rotateZ(-math.pi / 12.0),
        origin: const Offset(200, 0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          color: const Color(0xFFE8581C),
          child: const Text('Apartment for rent!'),
        ),
      ),
    );
  }
}