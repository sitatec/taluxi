import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taluxi/core/pages/loading_page.dart';
import 'package:taluxi/pages/home_page/home_page.dart';

import 'core/pages/connection_wrong_page.dart';
import 'pages/welcome_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appInitialisation = Firebase.initializeApp();

    return MaterialApp(
      title: 'Taluxi',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Color(0xFFFFA41C),
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: appInitialisation,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ConnectionWrongPage();
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return showAppEntryPage();
            }
            return LoadingPage();
          }),
    );
  }

  StreamBuilder showAppEntryPage() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        return (snapshot.data == null) ? WelcomePage() : HomePage();
      },
    );
  }
}
