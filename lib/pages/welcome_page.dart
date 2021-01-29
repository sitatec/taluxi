import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taluxi_common/taluxi_common.dart';
import 'package:user_manager/user_manager.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  AuthenticationProvider authProvider;
  bool waitDialogIsShown = false;
  bool signInRequested = false;
  final _buttonTextStyle = TextStyle(fontSize: 20, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthenticationProvider>(context, listen: true);
    if (authProvider.authState == AuthState.authenticating && signInRequested) {
      Future.delayed(Duration.zero, () async {
        waitDialogIsShown = true;
        showWaitDialog('Connexion en cours', context);
        signInRequested = false;
      });
    }
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter:
                  ColorFilter.mode(Color(0x65010101), BlendMode.luminosity),
              fit: BoxFit.cover,
              image: AssetImage('assets/images/bg.jpg'),
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Logo(
                  fontSize: 60,
                  taxiColor: Colors.white,
                  luxeColor: Color(0xFFFFAE00),
                ),
                SizedBox(height: screenSize.height * .17),
                _loginButton(),
                SizedBox(height: 20),
                _signUpButton(),
                SizedBox(height: 20),
                CustomDivider(),
                FacebookLoginButton(onClick: () async {
                  signInRequested = true;
                  await authProvider
                      .signInWithFacebook()
                      .then((_) => Navigator.of(context)
                          .popUntil((route) => route.isFirst))
                      .catchError(_onSignInError);
                }),
              ],
            ),
          ),
        ),
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

  Widget _loginButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ChangeNotifierProvider<AuthenticationProvider>.value(
              value: authProvider,
              child: AuthenticationPage(authType: AuthType.login),
            ),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 14.5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(0xffdf8e33).withAlpha(100),
              offset: Offset(2, 4),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
          gradient: mainLinearGradient,
        ),
        child: Text(
          'Se connecter',
          style: _buttonTextStyle,
        ),
      ),
    );
  }

  Widget _signUpButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ChangeNotifierProvider<AuthenticationProvider>.value(
              value: authProvider,
              child: AuthenticationPage(authType: AuthType.signUp),
            ),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(0x10000000),
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Text(
          'Créer un compte',
          style: _buttonTextStyle,
        ),
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    Key key,
  }) : super(key: key);

  final divider = const Expanded(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Divider(
        color: Colors.white,
        thickness: 1,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      divider,
      Text(
        "ou",
        style: TextStyle(color: Colors.white),
      ),
      divider
    ]);
  }
}
