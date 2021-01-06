import 'dart:async';

import 'package:user_manager/user_manager.dart';

class SignOutBusinessLogic {
  AuthenticationProvider authenticationProvider;
  final _streamController = StreamController<SignOutError>();

  SignOutBusinessLogic(this.authenticationProvider);

  Stream<SignOutError> get errorStream => _streamController.stream;

  Future<void> signOut() async {
    try {
      await authenticationProvider.signOut();
    } catch (e) {
      _handleError(e);
    }
  }

// TODO : create BusinessLogic class to make logics generic.
  void _handleError(dynamic error) {
    switch (error.runtimeType) {
      case AuthenticationException:
      case UserDataAccessException:
        _streamController.sink.add(
          SignOutError(
            errorMessage: error.message,
            errorTitle: 'Echec de la déconnexion',
          ),
        );
        break;
      default:
        _streamController.sink.add(
          SignOutError(
            errorMessage:
                "Une erreur critique est survenue lors de la déconnexion. Veuillez réessayer, si l'erreur persiste veuillez redémarrer l'application.",
            errorTitle: 'Echec de la déconnexion',
          ),
        );
    }
  }
}

class SignOutError {
  final String errorMessage;
  final String errorTitle;

  const SignOutError({
    this.errorMessage,
    this.errorTitle,
  });
}
