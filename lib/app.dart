import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:taluxi/pages/slash_page.dart';
import 'package:user_manager/user_manager.dart';

import 'core/pages/connection_wrong_page.dart';
import 'pages/home_page/home_page.dart';
import 'pages/welcome_page.dart';

class App extends StatelessWidget {
  // final UserRepository userRepository = UserRepository.instance;
  // final AuthenticationProvider authenticationProvider =
  //     AuthenticationProvider.instance;

  App();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
    // return MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider<AuthenticationProvider>.value(
    //       value: authenticationProvider,
    //     ),
    //     Provider<UserRepository>.value(
    //       value: userRepository,
    //       updateShouldNotify: (_, __) => false,
    //     )
    //   ],
    //   child: AppView(),
    // );
  }

  // void dispose() {
  //   // TODO: comprendre le comportement dispose où et quand l'utiliser.
  //   authenticationProvider.dispose();
  // }
}

class AppView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
// TODO create all theme constante and configure all theme default values.
    // final textTheme = Theme.of(context).textTheme;
    final authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    return MaterialApp(
      title: 'Taluxi',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Color(0xFFFFA41C),
        // textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
        //   bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
        // ),
      ),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: authProvider.authBinaryState,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ConnectionWrongPage();
          }
          if (snapshot.hasData) {
            if (snapshot.data == AuthState.authenticated) {
              return HomePage();
            }
            if (snapshot.data == AuthState.unauthenticated) {
              return WelcomePage();
            }
          }
          return SlashPage();
        },
      ),
    );
  }
}
