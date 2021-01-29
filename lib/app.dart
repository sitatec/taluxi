import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:real_time_location/real_time_location.dart';
import 'package:taluxi/pages/taxi_tracking_page/taxi_tracking_page.dart';
import 'package:taluxi_common/taluxi_common.dart';
import 'package:user_manager/user_manager.dart';

import 'pages/home_page/home_page.dart';
import 'pages/welcome_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return MaterialApp(
        title: 'Taluxi',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: Color(0xFFFFA41C),
        ),
        debugShowCheckedModeBanner: false,
        home: Provider.value(
          value: RealTimeLocation.instance,
          updateShouldNotify: (_, __) => false,
          child: TaxiTrackingPage({
            'sitatech': Coordinates(
                latitude: 11.309180549485705, longitude: -12.31927790730373)
          }),
        )
        //  FutureBuilder(
        //   future: initializeBackEndServices(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasError) {
        //       Navigator.of(context).push(
        //         MaterialPageRoute(builder: (context) => ConnectionWrongPage()),
        //       );
        //     }
        //     if (snapshot.connectionState == ConnectionState.done) {
        //       return ChangeNotifierProvider<AuthenticationProvider>.value(
        //         value: AuthenticationProvider.instance,
        //         child: AppEntryPoint(),
        //       );
        //     }
        //     return SlashPage();
        //   },
        // ),
        );
  }
}

// ignore: must_be_immutable
class AppEntryPoint extends StatelessWidget {
  AuthState _currentAuthState;
  @override
  Widget build(BuildContext context) {
    final authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
// TODO create all theme constante and configure all theme default values.
    return StreamBuilder(
      stream: authProvider.authBinaryState,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ConnectionWrongPage()),
          );
        } else if (snapshot.hasData) {
          if (_currentAuthState != snapshot.data) {
            if (snapshot.data == AuthState.authenticated) {
              return Provider.value(
                value: RealTimeLocation.instance,
                updateShouldNotify: (_, __) => false,
                child: HomePage(),
              );
            } else if (snapshot.data == AuthState.unauthenticated) {
              return WelcomePage();
            }
          }
        }
        return WaitingPage();
      },
    );
  }
}
