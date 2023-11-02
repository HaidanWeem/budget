import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  static const _dynamicLinkSignIn = 'https://budgetverification.page.link/';

  final _auth = FirebaseAuth.instance;

  Future<bool> sendSignInLinkToEmail(String email) async {
    try {
      await _auth.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: ActionCodeSettings(
          url: _dynamicLinkSignIn,
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
