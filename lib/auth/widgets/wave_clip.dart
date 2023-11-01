import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WaveClip extends CustomClipper<Path> {
  /// Divides the given height by this coefficient
  ///
  /// Determines the arc start height
  final double startHeightLine;

  final double arcHeightCoefficient;

  /// Divides the given height by this coefficient
  ///
  /// Determines the arc end height
  final double endHeightLine;

  WaveClip({
    required this.startHeightLine,
    required this.arcHeightCoefficient,
    required this.endHeightLine,
  });

  @override
  Path getClip(Size size) {
    final halfWidth = size.width / 2;
    final firstArcWidth = 0.25 * size.width;
    final lastArcWidth = 0.75 * size.width;
    final path = Path();

    path.lineTo(0, size.height / startHeightLine);

    path.quadraticBezierTo(
      firstArcWidth,
      size.height / arcHeightCoefficient,
      halfWidth,
      size.height / arcHeightCoefficient,
    );

    path.quadraticBezierTo(
      lastArcWidth,
      size.height / arcHeightCoefficient,
      size.width,
      size.height / endHeightLine,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
