import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:user_manager/user_manager.dart';

class SignUpBusinessLogic {
  AuthenticationProvider authenticationProvider;
  final _streamController = StreamController<SignUpError>();

  SignUpBusinessLogic(this.authenticationProvider);

  Stream<SignUpError> get errorStream => _streamController.stream;

  Future<void> signUp({
    @required String firstName,
    @required String lastName,
    @required String email,
    @required String password,
  }) async {
    try {
      await authenticationProvider.registerUser(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );
    } catch (e) {
      _handleError(e);
    }
  }

  void _handleError(dynamic error) {
    switch (error.runtimeType) {
      case AuthenticationException:
      case UserDataAccessException:
        _streamController.sink.add(
          SignUpError(
            errorMessage: error.message,
            errorTitle: 'Echec de l\'inscription',
          ),
        );
        break;
      default:
        _streamController.sink.add(
          SignUpError(
            errorMessage:
                "Une erreur critique est survenue lors de l'inscription. Veuillez réessayer, si l'erreur persiste veuillez redémarrer l'application.",
            errorTitle: 'Echec de l\'inscription',
          ),
        );
    }
  }
}

class SignUpError {
  final String errorMessage;
  final String errorTitle;

  const SignUpError({
    this.errorMessage,
    this.errorTitle,
  });
}
