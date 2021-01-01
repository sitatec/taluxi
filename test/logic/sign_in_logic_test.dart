import 'package:flutter_test/flutter_test.dart';
import 'package:taluxi/logic/sign_in_logic.dart';
import 'package:user_manager/user_manager.dart';

import '../mocks/authentication_provider_mock.dart';

void main() {
  SignInLogic signInLogic;
  AuthenticationProvider authenticationProvider;
  authenticationProvider = MockAuthenticationProvider();
  setUp(() {
    signInLogic = SignInLogic(authenticationProvider);
  });
  test(
      '[SignInLogic] should handle occured errors and add [SignUpError] with the corresponding error message to the [errorStream]',
      () async {
    await signInLogic.signInWithEmailAndPassword(email: '', password: '');
    expect(
      (await signInLogic.errorStream.first).errorMessage,
      equals(
          MockAuthenticationProvider.exceptionToBeThrownWhenSigningIn.message),
      reason: 'signInWithEmailAndPassword',
    );
  });

  test(
      '[SignInLogic] should handle occured errors and add [SignUpError] with the corresponding error message to the [errorStream]',
      () async {
    await signInLogic.signInWithFacebook();
    expect(
      (await signInLogic.errorStream.first).errorMessage,
      equals(
          MockAuthenticationProvider.exceptionToBeThrownWhenSigningIn.message),
      reason: 'signInWithFacebook',
    );
  });

  test(
      '[SignInLogic] should handle occured errors and add [SignUpError] with the corresponding error message to the [errorStream]',
      () async {
    await signInLogic.resetPassword('');
    expect(
      (await signInLogic.errorStream.first).errorMessage,
      equals(MockAuthenticationProvider
          .exceptionToBeThrownWhenResetingPassword.message),
      reason: 'resetPassword',
    );
  });
}
