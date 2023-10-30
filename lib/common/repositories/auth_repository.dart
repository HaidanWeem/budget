import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final _auth = FirebaseAuth.instance;

  Future<void> sendSignInLinkToEmail(String email) async {
    try {
      await _auth.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: ActionCodeSettings(
          url: 'https://budgetverification.page.link/',
          handleCodeInApp: true,
          androidPackageName: 'budget.budget',
        ),
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future<User?> signInWithEmailLink({
    required String email,
    required String link,
  }) async {
    try {
      final userCredentials = await _auth.signInWithEmailLink(
        email: email,
        emailLink: link,
      );

      return userCredentials.user;
    } catch (e) {
      throw e.toString();
    }
  }
}
