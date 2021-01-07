import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:taluxi/pages/slash_page.dart';
import 'package:user_manager/user_manager.dart';

import 'pages/connection_wrong_page.dart';
import 'pages/home_page/home_page.dart';
import 'pages/welcome_page.dart';

class App extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return MaterialApp(
        navigatorKey: _navigatorKey,
        title: 'Taluxi',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: Color(0xFFFFA41C),
        ),
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: initializeBackEndServices(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ConnectionWrongPage()),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return ChangeNotifierProvider<AuthenticationProvider>.value(
                value: AuthenticationProvider.instance,
                child: AppEntryPoint(_navigatorKey),
              );
            }
            return SlashPage();
          },
        ));
  }
}

class AppEntryPoint extends StatelessWidget {
  const AppEntryPoint(this._navigatorKey);
  final GlobalKey<NavigatorState> _navigatorKey;
  NavigatorState get _navigator => _navigatorKey.currentState;
  @override
  Widget build(BuildContext context) {
    final authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
// TODO create all theme constante and configure all theme default values.
    return StreamBuilder(
      stream: authProvider.authBinaryState,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          _navigator.push(
            MaterialPageRoute(builder: (context) => ConnectionWrongPage()),
          );
        }
        if (snapshot.hasData) {
          if (snapshot.data == AuthState.authenticated) {
            return HomePage();
            // _goTo(HomePage(), context, authProvider);
          } else if (snapshot.data == AuthState.unauthenticated) {
            return WelcomePage();
            // _goTo(WelcomePage(), context, authProvider)
          }
        }
        return SlashPage();
      },
    );
  }

  // void _goTo(Widget page, BuildContext context,
  //     AuthenticationProvider authProvider) async {
  //   await Future.delayed(Duration.zero);
  //   _navigator.pushAndRemoveUntil(
  //     MaterialPageRoute(builder: (context) {
  //       return ChangeNotifierProvider<AuthenticationProvider>.value(
  //         value: authProvider,
  //         child: page,
  //       );
  //     }),
  //     (_) => false,
  //   );
  // }
}
