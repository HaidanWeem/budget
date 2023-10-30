import 'package:flutter/material.dart';

class CostType {
  final String name;
  final int expenses;
  final Color color;

  const CostType({
    required this.name,
    this.expenses = 0,
    this.color = Colors.white,
  });
}
