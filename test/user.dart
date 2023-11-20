import 'package:budget/common/models/budget_user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const validUserEmail = 'example@example.com';

  test('User validation', () {
    expect(
      () => BudgetUser(email: 'example', id: ''),
      throwsA(isAssertionError),
    );
    expect(
      () => BudgetUser(email: validUserEmail, id: ''),
      throwsA(isAssertionError),
    );
    expect(
      BudgetUser(email: validUserEmail, id: 'id').email,
      validUserEmail,
    );
  });
}
