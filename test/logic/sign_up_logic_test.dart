import 'package:flutter_test/flutter_test.dart';
import 'package:taluxi/logic/sign_up_logic.dart';
import 'package:user_manager/user_manager.dart';

import '../mocks/authentication_provider_mock.dart';

void main() {
  SignUpBusinessLogic signUpBusinessLogic;
  AuthenticationProvider authenticationProvider;
  authenticationProvider = MockAuthenticationProvider();
  setUp(() {
    signUpBusinessLogic = SignUpBusinessLogic(authenticationProvider);
  });
  test(
      '[signUpBusinessLogic] should handle occured errors and add [SignUpError] with the corresponding error message to the [errorStream]',
      () async {
    await signUpBusinessLogic.signUp(
        email: '', password: '', firstName: 'null', lastName: 'null');
    expect(
      (await signUpBusinessLogic.errorStream.first).errorMessage,
      equals(
          MockAuthenticationProvider.exceptionToBeThrownWhenSigningUp.message),
      reason: 'signUp',
    );
  });
}
