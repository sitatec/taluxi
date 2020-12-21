import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';

class OAuthButton extends StatelessWidget {
  final double height;
  final double width;
  final String text;
  final String initials;
  final void Function() onClick;

  const OAuthButton({
    Key key,
    this.height = 59,
    this.width,
    @required this.initials,
    this.text,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        height: height,
        width: width, //?? MediaQuery.of(context).size.width * 0.8,
        margin: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff1959a9),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  initials,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff2872ba),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FacebookLoginButton extends StatelessWidget {
  const FacebookLoginButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OAuthButton(
      initials: "f",
      text: "Se connecter avec Facebook",
    );
  }
}

// ignore: must_be_immutable
class Logo extends StatelessWidget {
  Color _taxiColor;
  final double fontSize;

  Logo({Key key, bool backgroundColorIsOrange = false, this.fontSize = 30})
      : super(key: key) {
    _taxiColor = backgroundColorIsOrange ? Colors.white : mainLightLessColor;
  }
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Ta',
          style: GoogleFonts.lobsterTwo(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: fontSize,
            color: _taxiColor,
          ),
          children: [
            TextSpan(
                text: 'lu',
                style: TextStyle(fontSize: fontSize, color: Color(0xFF424141))),
            TextSpan(
              text: 'xi',
              style: TextStyle(color: _taxiColor, fontSize: fontSize),
            ),
          ]),
    );
  }
}
