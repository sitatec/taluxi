import 'package:flutter_test/flutter_test.dart';
import 'package:taluxi/logic/sign_out_logic.dart';
import 'package:user_manager/user_manager.dart';

import '../mocks/authentication_provider_mock.dart';

void main() {
  SignOutLogic signOutLogic;
  AuthenticationProvider authenticationProvider;
  authenticationProvider = MockAuthenticationProvider();
  setUp(() {
    signOutLogic = SignOutLogic(authenticationProvider);
  });
  test(
      '[signOutLogic] should handle occured errors and add [SignUpError] with the corresponding error message to the [errorStream]',
      () async {
    await signOutLogic.signOut();
    expect(
      (await signOutLogic.errorStream.first).errorMessage,
      equals(
          MockAuthenticationProvider.exceptionToBeThrownWhenSigningOut.message),
      reason: 'signOut',
    );
  });
}
