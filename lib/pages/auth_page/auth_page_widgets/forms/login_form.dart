import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taluxi/core/utils/form_fields_validators.dart';
import 'package:taluxi/core/widgets/core_widgts.dart';
import 'package:user_manager/user_manager.dart';

import 'commons_form_widgets.dart';

class LoginForm extends StatefulWidget {
  final void Function() onSignUpRequest;

  LoginForm({@required this.onSignUpRequest});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var password = '';
  var email = '';
  final _formKey = GlobalKey<FormState>();
  bool waitDialogIsShown = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final authProvider =
        Provider.of<AuthenticationProvider>(context, listen: true);

    if (authProvider.authState == AuthState.authenticating) {
      Future.delayed(Duration.zero, () {
        waitDialogIsShown = true;
        showWaitDialog('Connexion en cours', context);
      });
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: height * .21),
          Text(
            "Connexion",
            textScaleFactor: 1.88,
          ),
          SizedBox(height: height * .09),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  onChange: (value) => email = value,
                  title: "Email",
                  prefixIcon: Icon(Icons.email_rounded),
                  fieldType: TextInputType.emailAddress,
                  validator: emailFieldValidator,
                ),
                SizedBox(
                  height: 16,
                ),
                PasswordField(
                  onChanged: (value) => password = value,
                )
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          FormValidatorButton(onClick: () async {
            if (_formKey.currentState.validate()) {
              await authProvider
                  .signInWithEmailAndPassword(email: email, password: password)
                  .then((_) =>
                      Navigator.of(context).popUntil((route) => route.isFirst))
                  .catchError(_onSignInError);
            }
          }),
          SizedBox(
            height: 5,
          ),
          Container(
            margin: EdgeInsets.only(right: 7, top: 10),
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {},
              child: Text('Mot de passe oublié ?',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            ),
          ),
          SizedBox(height: height * .055),
          _signUpFormLink(),
        ],
      ),
    );
  }

  void _onSignInError(error) async {
    if (waitDialogIsShown) {
      Navigator.of(context).pop();
      waitDialogIsShown = false;
    }
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Echec de la connexion'),
          content: Text(error.message),
          actions: [
            Center(
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Fermer'),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _signUpFormLink() {
    return InkWell(
      onTap: widget.onSignUpRequest,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Pas encore inscrit ?  ',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            Text(
              'Cliquez ici pour le faire',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
