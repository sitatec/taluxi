import "package:flutter/material.dart";

import '../constants/colors.dart';

class CustomDrower extends StatelessWidget {
  final String userImageUrl;
  const CustomDrower({Key key, this.userImageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(gradient: mainLinearGradient),
            child: Center(
              child: userImageUrl == null
                  ? Icon(Icons.account_circle)
                  : Container(
                      color: Color(0xFFF1F1F1),
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(userImageUrl),
                        ),
                      ),
                    ),
            ),
          ),
          ListTile(
            onTap: () {
              //TODO: Logout user
            },
            title: Text("Se déconnecter"),
            trailing: Icon(
              Icons.logout,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
