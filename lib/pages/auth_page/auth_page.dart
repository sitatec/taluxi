import 'package:flutter/material.dart';

import 'auth_page_widgets/bezier_container.dart';
import 'auth_page_widgets/forms/login_form.dart';
import 'auth_page_widgets/forms/signup_form.dart';

class AuthenticationPage extends StatefulWidget {
  final AuthType authType;
  AuthenticationPage({Key key, this.authType}) : super(key: key);

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState(authType);
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  AuthType authType;
  _AuthenticationPageState(this.authType);

  @override
  Widget build(BuildContext context) {
    Widget form = authType == AuthType.login
        ? LoginForm(
            onSignUpRequest: () => setState(() => authType = AuthType.signUp))
        : SignUpForm(
            onLoginRequest: () => setState(() => authType = AuthType.login));

    final screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            height: screenSize.height,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -screenSize.height * .15,
                  right: -screenSize.width * .4,
                  child: BezierContainer(),
                ),
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: form,
                  ),
                ),
                Positioned(
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum AuthType { login, signUp }
