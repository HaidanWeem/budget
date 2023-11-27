import 'package:flutter/material.dart';

class BudgetIconButton extends StatelessWidget {
  static const _size = Size(56, 56);

  final Widget icon;
  final VoidCallback onTap;
  final Color color;
  final Color splashColor;

  const BudgetIconButton({
    required this.icon,
    required this.onTap,
    this.color = Colors.greenAccent,
    this.splashColor = Colors.green,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          splashColor: splashColor,
          onTap: onTap,
          child: SizedBox.fromSize(size: _size, child: icon),
        ),
      ),
    );
  }
}
