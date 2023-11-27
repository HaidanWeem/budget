import 'dart:async';

import 'package:budget/common/models/budget_operation.dart';
import 'package:budget/core/repositories/abstract_models.dart/i_balance_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BalanceNotifier extends ChangeNotifier {
  final IBalanceRepository _balanceRepository;

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>?
      detailSubscription;

  double _balance = 0.0;
  List<BudgetOperation> _operations = [];

  double get balance => _balance;
  List<BudgetOperation> get operations => _operations;

  set balance(double balance) {
    _balance = balance;
    notifyListeners();
  }

  set operations(List<BudgetOperation> operations) {
    _operations = operations;
    notifyListeners();
  }

  BalanceNotifier(this._balanceRepository) {
    detailSubscription =
        _balanceRepository.balanceChanges.listen(_balanceChangesListener);
  }

  Future<void> _balanceChangesListener(
      DocumentSnapshot<Map<String, dynamic>> event) async {
    final balanceString = event.data()?['balance'].toString();

    if (balanceString == null) return;

    balance = double.parse(balanceString);
    operations = await _fetchOperations();
  }

  Future<List<BudgetOperation>> _fetchOperations() =>
      _balanceRepository.fetchOperations();

  Future<void> createOperation(BudgetOperation operation) =>
      _balanceRepository.createOperation(operation);

  Future<void> updateBalance(double balance) =>
      _balanceRepository.updateBalance(balance);

  @override
  void dispose() {
    detailSubscription?.cancel();
    _balanceRepository.dispose();
    super.dispose();
  }
}
