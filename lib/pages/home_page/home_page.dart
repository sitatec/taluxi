import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taluxi/core/constants/colors.dart';
import 'package:taluxi/core/widgets/core_widgts.dart';
import 'package:taluxi/core/widgets/custom_drawer.dart';
import 'package:taluxi/pages/home_page/home_page_widgets.dart';
import 'package:taluxi/pages/taxi_tracker_page/taxi_tracker_page.dart';

final customWhiteColor = Color(0xF5FCFAFA);

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  final bottomConatainerBorderRadius = Radius.circular(40);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final floatingActionButtonSize = deviceSize.height * 0.09;
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) => Stack(children: [
          Container(
            decoration: BoxDecoration(gradient: mainLinearGradient),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HeaderContainer(deviceSize: deviceSize),
                BottomRoundedContainer(
                  deviceSize: deviceSize,
                  topBorderRadius: bottomConatainerBorderRadius,
                ),
              ],
            ),
          ),
          Positioned(
            left: 10,
            top: 67,
            child: Container(
              height: 48,
              width: 50,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 5,
                      offset: Offset(0, 3),
                      color: Colors.black54)
                ],
                image: DecorationImage(
                    image: NetworkImage(
                      "https://purrandroardotcom1.files.wordpress.com/2015/08/17735-lion-face-pv.jpg",
                    ),
                    fit: BoxFit.cover),
                // shape: BoxShape.circle,
                color: customWhiteColor,
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 67,
            child: Container(
              decoration: BoxDecoration(
                color: customWhiteColor,
                borderRadius: BorderRadius.circular(9),
              ),
              child: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              ),
            ),
          )
        ]),
      ),
      endDrawer: CustomDrower(),
      floatingActionButton: Container(
        child: CustomElevatedButton(
          child: Logo(backgroundColorIsOrange: true, fontSize: 45),
          elevation: 5.5,
          height: floatingActionButtonSize,
          width: floatingActionButtonSize * 2.3,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaxiTracker(),
            ),
          ),
        ),
        margin: EdgeInsets.only(bottom: deviceSize.height * .12),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class HeaderContainer extends StatelessWidget {
  const HeaderContainer({
    Key key,
    @required this.deviceSize,
  }) : super(key: key);

  final Size deviceSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: deviceSize.width * 0.35,
          right: deviceSize.width * 0.11,
          left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bonjour",
            textScaleFactor: 3.7,
            style: GoogleFonts.patuaOne(color: customWhiteColor),
          ),
          Center(
            child: Text(
              "Alpha,",
              textScaleFactor: 2.8,
              style: GoogleFonts.patuaOne(color: customWhiteColor),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomRoundedContainer extends StatelessWidget {
  const BottomRoundedContainer({
    Key key,
    @required this.deviceSize,
    @required this.topBorderRadius,
  }) : super(key: key);

  final Size deviceSize;
  final Radius topBorderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: deviceSize.height * 0.65,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: customWhiteColor,
        borderRadius: BorderRadius.only(
          topLeft: topBorderRadius,
          topRight: topBorderRadius,
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(top: 30),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          "Pour trouver un taxi, vous avez juste à cliquez sur le bouton ci-dessous on s'occupera de vous mettre en contact avec le taxi le plus proche de l'endroit où vous vous trouvez actuellement.",
          textScaleFactor: 1.5,
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}
