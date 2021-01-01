import 'package:flutter/material.dart';

import '../../../home_page/home_page.dart';
import 'commons_form_widgets.dart';

class LoginForm extends StatefulWidget {
  final void Function() onSignUpRequest;

  LoginForm({@required this.onSignUpRequest});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
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
              children: const [
                emailField,
                SizedBox(
                  height: 16,
                ),
                PasswordField()
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          FormValidatorButton(onClick: () {
            if (_formKey.currentState.validate())
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return HomePage();
              }));
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
