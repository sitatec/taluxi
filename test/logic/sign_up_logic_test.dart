import 'package:flutter_test/flutter_test.dart';
import 'package:taluxi/logic/sign_up_logic.dart';
import 'package:user_manager/user_manager.dart';

import '../mocks/authentication_provider_mock.dart';

void main() {
  SignUpLogic signUpLogic;
  AuthenticationProvider authenticationProvider;
  authenticationProvider = MockAuthenticationProvider();
  setUp(() {
    signUpLogic = SignUpLogic(authenticationProvider);
  });
  test(
      '[signUpLogic] should handle occured errors and add [SignUpError] with the corresponding error message to the [errorStream]',
      () async {
    await signUpLogic.signUp(
        email: '', password: '', firstName: 'null', lastName: 'null');
    expect(
      (await signUpLogic.errorStream.first).errorMessage,
      equals(
          MockAuthenticationProvider.exceptionToBeThrownWhenSigningUp.message),
      reason: 'signUp',
    );
  });
}
