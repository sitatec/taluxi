import 'package:flutter_test/flutter_test.dart';
import 'package:taluxi/logic/sign_in_logic.dart';
import 'package:user_manager/user_manager.dart';

import '../mocks/authentication_provider_mock.dart';

void main() {
  SignInBusinessLogic signInBusinessLogic;
  AuthenticationProvider authenticationProvider;
  authenticationProvider = MockAuthenticationProvider();
  setUp(() {
    signInBusinessLogic = SignInBusinessLogic(authenticationProvider);
  });
  test(
      '[SignInBusinessLogic] should handle occured errors and add [SignUpError] with the corresponding error message to the [errorStream]',
      () async {
    await signInBusinessLogic.signInWithEmailAndPassword(
        email: '', password: '');
    expect(
      (await signInBusinessLogic.errorStream.first).errorMessage,
      equals(
          MockAuthenticationProvider.exceptionToBeThrownWhenSigningIn.message),
      reason: 'signInWithEmailAndPassword',
    );
  });

  test(
      '[SignInBusinessLogic] should handle occured errors and add [SignUpError] with the corresponding error message to the [errorStream]',
      () async {
    await signInBusinessLogic.signInWithFacebook();
    expect(
      (await signInBusinessLogic.errorStream.first).errorMessage,
      equals(
          MockAuthenticationProvider.exceptionToBeThrownWhenSigningIn.message),
      reason: 'signInWithFacebook',
    );
  });

  test(
      '[SignInBusinessLogic] should handle occured errors and add [SignUpError] with the corresponding error message to the [errorStream]',
      () async {
    await signInBusinessLogic.resetPassword('');
    expect(
      (await signInBusinessLogic.errorStream.first).errorMessage,
      equals(MockAuthenticationProvider
          .exceptionToBeThrownWhenResetingPassword.message),
      reason: 'resetPassword',
    );
  });
}
