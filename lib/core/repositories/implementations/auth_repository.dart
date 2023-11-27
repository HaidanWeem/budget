import 'dart:developer';

import 'package:budget/core/budget_messages.dart';
import 'package:budget/core/repositories/abstract_models.dart/i_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class AuthRepository implements IAuthRepository {
  static const _applicationId = 'budget.budget';
  static const _dynamicLinkSignIn =
      'https://budgetverification.page.link/verify';

  final _auth = FirebaseAuth.instance;
  final _dynamicLinks = FirebaseDynamicLinks.instance;

  Stream<PendingDynamicLinkData> get _onLink => _dynamicLinks.onLink;

  @override
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  AuthRepository() {
    _onLink.listen(_onLinkListener);
  }

  Future<void> _onLinkListener(PendingDynamicLinkData event) async {
    try {
      final continueUrl = event.link.queryParameters['continueUrl'] ?? '';
      final email = Uri.parse(continueUrl).queryParameters['email'];

      if (email == null) throw BudgetMessages.invalidLink;

      await _signInWithEmailLink(email: email, link: event.link.toString());
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<bool> sendSignInLinkToEmail(String email) async {
    try {
      await _auth.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: ActionCodeSettings(
          url: '$_dynamicLinkSignIn?email=$email',
          handleCodeInApp: true,
          androidPackageName: _applicationId,
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

  @override
  Future<void> signOut() => _auth.signOut();
}
