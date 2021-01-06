import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_manager/user_manager.dart';

import '../../core/constants/colors.dart';
import '../../core/widgets/core_widgts.dart';
import '../../core/widgets/custom_drawer.dart';
import '../taxi_tracker_page/taxi_tracker_page.dart';
import 'home_page_widgets.dart';

final customWhiteColor = Color(0xF5FCFAFA);

//TODO Refactoring : extracted widgets for better names.
// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);
  AuthenticationProvider _authProvider;
  User _user;
  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthenticationProvider>(context, listen: false);
    _user = _authProvider.user;
    final deviceSize = MediaQuery.of(context).size;
    final floatingActionButtonSize = deviceSize.height * 0.085;
    final userHasPhoto = (_user.photoUrl != null && _user.photoUrl.isNotEmpty);
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) => Stack(children: [
          Container(
            decoration: BoxDecoration(gradient: mainLinearGradient),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _headerContainer(deviceSize),
                BottomRoundedContainer(
                  deviceSize: deviceSize,
                  topBorderRadius: Radius.circular(40),
                ),
              ],
            ),
          ),
          Positioned(
            left: 10,
            top: 60,
            child: Container(
                height: 48,
                width: 49,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5,
                        offset: Offset(0, 2),
                        color: Colors.black12)
                  ],
                  image: userHasPhoto
                      ? DecorationImage(
                          image: NetworkImage(
                            _user.photoUrl,
                          ),
                          fit: BoxFit.cover,
                        )
                      : null,
                  // shape: BoxShape.circle,
                  color: customWhiteColor,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: userHasPhoto
                    ? null
                    : Icon(
                        Icons.person,
                        color: Colors.black38,
                        size: 43,
                      )),
          ),
          Positioned(
            right: 10,
            top: 60,
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
          child: Logo(backgroundColorIsOrange: true, fontSize: 43),
          height: floatingActionButtonSize,
          width: floatingActionButtonSize * 2.2,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ChangeNotifierProvider<AuthenticationProvider>.value(
                value: _authProvider,
                child: TaxiTracker(),
              ),
            ),
          ),
        ),
        margin: EdgeInsets.only(bottom: deviceSize.height * .09),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _headerContainer(Size deviceSize) {
    return Padding(
      padding: EdgeInsets.only(
          top: deviceSize.width * 0.35,
          right: deviceSize.width * 0.11,
          left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bienvenue",
            textScaleFactor: 3.4,
            style: TextStyle(fontFamily: 'PatuaOne', color: customWhiteColor),
          ),
          Center(
            child: Text(
              _user.formatedName,
              textScaleFactor: 2.9,
              style: TextStyle(fontFamily: 'PatuaOne', color: customWhiteColor),
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
        margin: EdgeInsets.only(top: 40),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          "Pour trouver un taxi, vous avez juste à cliquez sur le bouton ci-dessous on s'occupera de vous mettre en contact avec le taxi le plus proche de l'endroit où vous vous trouvez actuellement.",
          textScaleFactor: 1.5,
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
