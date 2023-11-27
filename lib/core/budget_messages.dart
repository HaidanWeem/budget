class BudgetMessages {
  static const welcomeBack = 'Welcome back';
  static const email = 'Email address';
  static const continueA = 'Continue';

  static const forbidden = 'Forbidden';

  //Error messages
  static const emailIsNotValid = 'Email is not valid';
  static const invalidLink = 'Link is not valid';

  static const emailRegexp = r'^\S+@\S+\.\S+$';

  static String showMessageEmailSent(String email) =>
      'We have sent you a confirmation \nto your email $email '
      '\n\nPlease follow the link in the email \n'
      'to login to your account.';
}
