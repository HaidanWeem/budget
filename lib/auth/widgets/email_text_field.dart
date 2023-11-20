import 'package:budget/core/budget_colors.dart';
import 'package:budget/core/budget_messages.dart';
import 'package:flutter/material.dart';

class EmailTextField extends StatefulWidget {
  final TextEditingController controller;

  const EmailTextField({required this.controller, super.key});

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  final _focusNode = FocusNode();

  bool _isFocused = false;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(_focusNodeListener);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      controller: widget.controller,
      validator: validator,
      decoration: InputDecoration(
        label: const Text(BudgetMessages.email),
        labelStyle: TextStyle(color: _isFocused ? BudgetColors.border : null),
        focusedBorder: _border(BudgetColors.border),
        enabledBorder: _border(Colors.grey),
        errorBorder: _border(BudgetColors.error),
        focusedErrorBorder: _border(BudgetColors.error),
      ),
    );
  }

  void _focusNodeListener() => setState(() => _isFocused = _focusNode.hasFocus);

  OutlineInputBorder _border(Color color) {
    const borderWidth = 1.5;

    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(width: borderWidth, color: color),
    );
  }

  String? validator(String? value) {
    final regExp = RegExp(BudgetMessages.emailRegexp);
    if (regExp.hasMatch(value ?? '')) return null;

    return BudgetMessages.emailIsNotValid;
  }
}
