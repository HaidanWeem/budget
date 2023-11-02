class BudgetMessages {
  static const welcomeBack = 'Welcome back';
  static const email = 'Email address';
  static const continueA = 'Continue';
  static String showMessageEmailSent(String email) =>
      'We have sent you a confirmation \nto your email $email '
      '\n\nPlease follow the link in the email \n'
      'to login to your account.';

  //Error messages
  static const emailIsNotValid = 'Email is not valid';
}
