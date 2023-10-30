import 'package:budget/auth/widgets/wave_clip.dart';
import 'package:budget/core/budget_colors.dart';
import 'package:flutter/material.dart';

class BudgetAppBar extends StatefulWidget {
  const BudgetAppBar({super.key});

  @override
  State<BudgetAppBar> createState() => _BudgetAppBarState();
}

class _BudgetAppBarState extends State<BudgetAppBar> {
  static const _layers = [
    _Wave(
      startHeightLine: 2,
      arcHeightCoefficient: 3.15,
      endHeightLine: 5.5,
      color: BudgetColors.linary,
    ),
    _Wave(
      startHeightLine: 2.3,
      arcHeightCoefficient: 3.25,
      endHeightLine: 6.5,
      color: BudgetColors.secondary,
    ),
    _Wave(
      startHeightLine: 2.75,
      arcHeightCoefficient: 3.25,
      endHeightLine: 8,
      color: BudgetColors.primary,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _layers
          .map(
            (e) => ClipPath(
              clipper: WaveClip(
                startHeightLine: e.startHeightLine,
                arcHeightCoefficient: e.arcHeightCoefficient,
                endHeightLine: e.endHeightLine,
              ),
              child: Container(color: e.color),
            ),
          )
          .toList(),
    );
  }
}

class _Wave {
  final double startHeightLine;
  final double arcHeightCoefficient;
  final double endHeightLine;
  final Color color;

  const _Wave({
    required this.startHeightLine,
    required this.arcHeightCoefficient,
    required this.endHeightLine,
    required this.color,
  });
}
