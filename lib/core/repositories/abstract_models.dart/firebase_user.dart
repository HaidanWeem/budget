import 'package:budget/core/budget_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';

mixin class FirebaseUser {
  User get user {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) throw BudgetMessages.forbidden;

    return user;
  }
}
