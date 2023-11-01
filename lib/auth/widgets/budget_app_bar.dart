import 'package:budget/auth/widgets/wave_clip.dart';
import 'package:budget/core/budget_colors.dart';
import 'package:flutter/material.dart';

class BudgetAppBar extends StatelessWidget {
  static const _layers = [
    _Wave(
      arcHeightCoefficient: 1.575,
      endHeightLine: 2.75,
      color: BudgetColors.linary,
    ),
    _Wave(
      startHeightLine: 1.15,
      arcHeightCoefficient: 1.625,
      endHeightLine: 3.25,
      color: BudgetColors.secondary,
    ),
    _Wave(
      startHeightLine: 1.375,
      arcHeightCoefficient: 1.625,
      endHeightLine: 4,
      color: BudgetColors.primary,
    ),
  ];

  const BudgetAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = screenHeight / 2;
    final logoBottomPadding = screenHeight / 5;

    return SizedBox(
      height: appBarHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ..._layers.map(
            (e) => ClipPath(
              clipper: WaveClip(
                startHeightLine: e.startHeightLine,
                arcHeightCoefficient: e.arcHeightCoefficient,
                endHeightLine: e.endHeightLine,
              ),
              child: Container(color: e.color),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: logoBottomPadding),
            child: const Text(
              'LOGO',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class _Wave {
  final double startHeightLine;
  final double arcHeightCoefficient;
  final double endHeightLine;
  final Color color;

  const _Wave({
    required this.arcHeightCoefficient,
    required this.endHeightLine,
    required this.color,
    this.startHeightLine = 1,
  });
}
