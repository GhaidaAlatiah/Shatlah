import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shatlah2/Register.dart';
import 'package:shatlah2/logIn.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


class home_logout extends StatefulWidget {
  home_logout({
    Key key,
  }) : super(key: key);

  @override
  _home_logoutState createState() => _home_logoutState();
}

class _home_logoutState extends State<home_logout> {
 FirebaseAuth instance = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(0.0, 745.0),
            child: Container(
              width: 412.0,
              height: 80.0,
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff000000),
                    offset: Offset(0, 3),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
          ),

          Transform.translate(
            offset: Offset(0.0, -31.0),
            child: Container(
              width: 412.0,
              height: 231.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(52.0),
                color: const Color(0x9f084a2e),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x29000000),
                    offset: Offset(0, 3),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
          ),

          Transform.translate(
            offset: Offset(10.0, 65.0),
            child:
            // Adobe XD layer: 'image' (shape)
            Container(
              width: 30.0,
              height: 30.0,
              child: FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(
                    Icons.arrow_back_ios
                ),
              ),
            ),
          ),

          Transform.translate(
            offset: Offset(310.0, 755.0),
            child: Container(
              width: 55.0,
              height: 55.0,
              child: FlatButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Register()));
                },
                child: Icon(
                Icons.account_circle_outlined,
                size: 55.0,
                   ),
                ),
              ),
            ),

        ],
      ),
    );
  }
}
