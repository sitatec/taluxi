import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:user_manager/user_manager.dart';

class SignInLogic {
  AuthenticationProvider authenticationProvider;
  final _streamController = StreamController<SignInError>();

  SignInLogic(this.authenticationProvider);

  Stream<SignInError> get errorStream => _streamController.stream;

  Future<void> signInWithEmailAndPassword(
      {@required String email, @required String password}) async {
    try {
      await authenticationProvider.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      await authenticationProvider.signInWithFacebook();
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await authenticationProvider.sendPasswordResetEmail(email);
    } catch (e) {
      _handleError(e);
    }
  }

  void _handleError(dynamic error) {
    switch (error.runtimeType) {
      case AuthenticationException:
      case UserDataAccessException:
        _streamController.sink.add(
          SignInError(
            errorMessage: error.message,
            errorTitle: 'Echec de la connexion',
          ),
        );
        break;
      default:
        _streamController.sink.add(
          SignInError(
            errorMessage:
                "Une erreur critique est survenue lors de la connexion. Veuillez réessayer, si l'erreur persiste veuillez redémarrer l'application.",
            errorTitle: 'Echec de la connexion',
          ),
        );
    }
  }
}

class SignInError {
  final String errorMessage;
  final String errorTitle;

  const SignInError({
    this.errorMessage,
    this.errorTitle,
  });
}
