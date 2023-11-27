import 'dart:ui';

import 'package:budget/auth/state/auth_notifier.dart';
import 'package:budget/balance/state/balance_notifier.dart';
import 'package:budget/common/models/budget_operation.dart';
import 'package:budget/common/models/operation_type.dart';
import 'package:budget/common/widget/budget_button.dart';
import 'package:budget/common/widget/budget_icon_button.dart';
import 'package:budget/core/budget_colors.dart';
import 'package:budget/core/repositories/implementations/balance_repository.dart';
import 'package:budget/core/state/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mccounting_text/mccounting_text.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends AuthState<HomePage> {
  static const _expandedHeightKoef = 0.3;

  double oldBalance = 0;
  double newBalance = 0;

  @override
  Widget build(BuildContext context) {
    final balanceNotifier = context.watch<BalanceNotifier>();
    newBalance = balanceNotifier.balance;
    final operations = balanceNotifier.operations;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: BudgetColors.primary,
            floating: true,
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: McCountingText(
                      begin: oldBalance,
                      end: newBalance,
                      precision: 2,
                      duration: const Duration(milliseconds: 1500),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 36,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BudgetIconButton(
                        icon: const Icon(Icons.add),
                        onTap: () => _showDialog(OperationType.income),
                      ),
                      BudgetIconButton(
                        icon: const Icon(Icons.remove),
                        onTap: () => _showDialog(OperationType.spending),
                        color: Colors.orangeAccent,
                        splashColor: Colors.orange,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            expandedHeight:
                MediaQuery.of(context).size.height * _expandedHeightKoef,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) =>
                  ListTile(title: Text('Item #${operations[index].value}')),
              childCount: operations.length,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showDialog(OperationType operationType) {
    final priceController = TextEditingController();
    final sectorController = TextEditingController();

    return showAdaptiveDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        final screenSize = MediaQuery.of(context).size;
        final height = screenSize.height * 0.5;
        final width = screenSize.width * 0.9;
        final filter = ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0);
        final balance = context.read<BalanceNotifier>().balance;

        return Center(
          child: BackdropFilter(
            filter: filter,
            child: Container(
              width: width,
              height: height,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.white60,
              ),
              child: Column(
                children: [
                  TextFormField(
                    controller: priceController,
                    validator: (value) {},
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp('[0-9]+[,.]{0,1}[0-9]*'),
                      ),
                      TextInputFormatter.withFunction(
                        (oldValue, newValue) => newValue.copyWith(
                          text: newValue.text.replaceAll('.', ','),
                        ),
                      ),
                    ],
                    decoration: const InputDecoration(
                      label: Text('Price'),
                      errorText: 'Invalid value',
                    ),
                  ),
                  TextFormField(
                    controller: sectorController,
                    decoration: const InputDecoration(
                      label: Text('Sector'),
                      errorText: 'Invalid value',
                    ),
                  ),
                  Text('Balance: $balance'),
                  const Spacer(),
                  BudgetButton(
                    text: 'Execute',
                    onPressed: () {
                      context.read<BalanceNotifier>().createOperation(
                            BudgetOperation(
                              balance: balance,
                              value: double.parse(priceController.text),
                              operationType: operationType,
                              sector: sectorController.text,
                              operationTime: DateTime.now(),
                            ),
                          );
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
