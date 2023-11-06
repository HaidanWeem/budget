import 'dart:developer';

import 'package:budget/core/budget_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class AuthRepository {
  static const _dynamicLinkSignIn =
      'https://budgetverification.page.link/verify';

  final _auth = FirebaseAuth.instance;
  final _dynamicLinks = FirebaseDynamicLinks.instance;

  Stream<PendingDynamicLinkData> get onLink => _dynamicLinks.onLink;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  AuthRepository() {
    onLink.listen(onLinkListener);
  }

  Future<void> onLinkListener(PendingDynamicLinkData event) async {
    try {
      print(event.link);
      final continueUrl = event.link.queryParameters['continueUrl'] ?? '';
      final email = Uri.parse(continueUrl).queryParameters['email'];

      if (email == null) throw BudgetMessages.invalidLink;

      await _signInWithEmailLink(email: email, link: event.link.toString());
    } catch (e) {
      log(e.toString());
    }
  }

  Future<bool> sendSignInLinkToEmail(String email) async {
    try {
      await _auth.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: ActionCodeSettings(
          url: '$_dynamicLinkSignIn?email=$email',
          handleCodeInApp: true,
          androidPackageName: 'budget.budget',
        ),
      );

      return true;
    } catch (e) {
      log(e.toString());

      return false;
    }
  }

  Future<void> _signInWithEmailLink({
    required String email,
    required String link,
  }) async {
    try {
      await _auth.signInWithEmailLink(
        email: email,
        emailLink: link,
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> signOut() => _auth.signOut();
}
