import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../widgets/core_widgts.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print("loging...");
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
            vertical: deviceSize.height * 0.19,
            horizontal: deviceSize.width * 0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Logo(
              fontSize: 40,
            ),
            Card(
              child: Container(
                height: deviceSize.height * 0.28,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Lottie.asset(
                        "assets/images/animations/loading_animation.json",
                        fit: BoxFit.cover,
                        width: 120,
                        height: 120),
                    Text(
                      "   Veuillez patiantez un instant s'il vous plait.   ",
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.3,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox()
          ],
        ),
      ),
    );
  }
}
