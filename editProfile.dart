import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shatlah2/generalGuide.dart';
import 'package:shatlah2/home_logout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shatlah2/logIn.dart';
import 'package:page_transition/page_transition.dart';

class editProfile extends StatefulWidget {
  editProfile({
    Key key,
  }) : super(key: key);

  @override
  _editProfileState createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  @override
  String _setName = '', _setPassword = '';
  var setKey= GlobalKey<ScaffoldState>();
  final _databaseRef = FirebaseDatabase.instance.reference(); //database reference object


  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: <Widget>[
         /* Transform.translate(
            offset: Offset(0, 655),
            child:
                Container(
              width: 410,
              height: 180,

              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/images/plantBackground.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),*/

         /* Transform.translate(
            offset: Offset(-1.0, -264.0),
            child: Container(
              width: 413.0,
              height: 998.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(53.0),
                color: const Color(0xffffffff),
              ),
            ),
          ),*/

          Transform.translate(
            offset: Offset(0.0, -140.0),
            child: Container(
              width: 412.0,
              height: 797.0,
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
            offset: Offset(49.0, 180.0),
            child: Text(
              'إعدادات الحساب',
              style: TextStyle(
                fontFamily: 'plus',
                fontSize: 43,
                color: const Color(0xffffffff),
              ),
              textAlign: TextAlign.left,
            ),
          ),


          Transform.translate(
            offset: Offset(49.0, 290.0),
            child: Container(
              width: 315.0,
              height: 47.0,
              child: TextField (
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),

                decoration: InputDecoration (
                  filled: true,
                  fillColor: Colors.white70,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black12,//this has no effect
                    ),
                    borderRadius: BorderRadius.circular(50.0),
                  ),

                  hintText: "الاسم",
                  hintStyle: TextStyle(
                    color: Colors.black38,
                    fontSize: 14.5,
                    height: 4.5,
                  ),
                  border: InputBorder.none,
                ),

                onChanged: (value) {
                  setState(() {
                    this._setName = value;
                  });
                },
              ),
            ),
          ),

          Transform.translate(
            offset: Offset(49.0, 350.0),
            child: Container(
              width: 315.0,
              height: 47.0,
              child: TextField (
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),

                decoration: InputDecoration (
                  filled: true,
                  fillColor: Colors.white70,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black12,//this has no effect
                    ),
                    borderRadius: BorderRadius.circular(50.0),
                  ),

                  hintText: "كلمة المرور الجديدة",
                  hintStyle: TextStyle(
                    color: Colors.black38,
                    fontSize: 14.5,
                    height: 3.5,
                  ),
                  border: InputBorder.none,
                ),
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                   this._setPassword = value;
                  });
                },
              ),
            ),
          ),


          Transform.translate(
            offset: Offset(54.0, 450.0),
            child: Container(
              width: 120.0,
              height: 41.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(21.0),
                color: const Color(0x6a000d06),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
            child: FlatButton(
              child: Text(
                'تسجيل خروج',
                style: TextStyle(
                  fontFamily: 'plus',
                  fontSize: 15,
                  height: 1,
                  color: const Color(0xffffffff),
                ),
                textAlign: TextAlign.center,
              ), onPressed: (){
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => logIn()));

            },
            ),
          ),
          ),


              Transform.translate(
                offset: Offset(295.0, 450.0),
    child: Container(
    width: 70.0,
    height: 41.0,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(21.0),
    color: const Color(0x6a000d06),
    border: Border.all(width: 1.0, color: const Color(0xff707070)),
    ),
            child: FlatButton(
              child: Text(
                'حفظ',
                style: TextStyle(
                  fontFamily: 'plus',
                  fontSize: 17,
                  height: 1,
                  color: const Color(0xffffffff),
                ),
                textAlign: TextAlign.center,
              ),
              onPressed: () async {

                User _auth = FirebaseAuth.instance.currentUser;


                  if(_setPassword=='' && _setName != ''){
                   await _databaseRef.orderByChild('email').equalTo(logUser.getEmail()).once().then((DataSnapshot snap) {
                      var userKey = snap.value.keys;

                      _databaseRef.child(userKey.toString().substring(1, userKey
                          .toString()
                          .length - 1)).update({"name": _setName.toString()});
                    },
                    );

                   Widget okButton = FlatButton(
                       child: Text("حسنًا",
                           textAlign: TextAlign.right,
                           textDirection: TextDirection.rtl,
                           style: TextStyle(
                               color: const Color(0xff598270),
                               fontWeight: FontWeight.bold)),
                       onPressed: () {
                         Navigator.pop(context);
                       }
                   );
                   AlertDialog alert = AlertDialog(
                     content: Text(
                       "تم تحديث الأسم",
                       textAlign: TextAlign.right,
                       textDirection: TextDirection.rtl,
                     ),
                     actions: [
                       okButton,
                     ],
                   );
                   showDialog(
                     context: context, builder: (BuildContext context) {
                     return alert;
                   },
                   );

                } else if(_setPassword != '' && _setName=='') {

                    try{
                     await _auth.updatePassword(_setPassword);


                      Widget okButton = FlatButton(
                          child: Text("حسنًا",
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: const Color(0xff598270),
                                  fontWeight: FontWeight.bold)),
                          onPressed: () {
                            Navigator.pop(context);
                          }
                      );
                      AlertDialog alert = AlertDialog(
                        content: Text(
                          "تم تحديث كلمة المرور",
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                        ),
                        actions: [
                          okButton,
                        ],
                      );
                      showDialog(
                        context: context, builder: (BuildContext context) {
                        return alert;
                      },
                      );
}
                    on FirebaseAuthException catch (e){

                      Widget okButton = FlatButton(
                          child: Text("حسنًا",
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: const Color(0xff598270),
                                  fontWeight: FontWeight.bold)),
                          onPressed: () {
                            Navigator.pop(context);
                          }
                      );
                      AlertDialog alert = AlertDialog(
                        content: Text(
                          "كلمة المرور ضعيفة!",
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                        ),
                        actions: [
                          okButton,
                        ],
                      );
                      showDialog(
                        context: context, builder: (BuildContext context) {
                        return alert;
                      },
                      );

                    }

                }else if(_setPassword != '' && _setName != '') {
                    try{
                      await _auth.updatePassword(_setPassword);
                      await   _databaseRef.orderByChild('email').equalTo(logUser.getEmail()).once().then((DataSnapshot snap) {
                      var userKey = snap.value.keys;

                      _databaseRef.child(userKey.toString().substring(1, userKey
                          .toString()
                          .length - 1)).update({"name": _setName.toString()});
                    },
                    );
                      Widget okButton = FlatButton(
                          child: Text("حسنًا",
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: const Color(0xff598270),
                                  fontWeight: FontWeight.bold)),
                          onPressed: () {
                            Navigator.pop(context);
                          }
                      );
                      AlertDialog alert = AlertDialog(
                        content: Text(
                          "تم تحديث بياناتك ",
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                        ),
                        actions: [
                          okButton,
                        ],
                      );
                      showDialog(
                        context: context, builder: (BuildContext context) {
                        return alert;
                      },
                      );
                    }
                    on FirebaseAuthException catch (e){

                        Widget okButton = FlatButton(
                            child: Text("حسنًا",
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    color: const Color(0xff598270),
                                    fontWeight: FontWeight.bold)),
                            onPressed: () {
                              Navigator.pop(context);
                            }
                        );
                        AlertDialog alert = AlertDialog(
                          content: Text(
                            "كلمة المرور ضعيفة!",
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                          ),
                          actions: [
                            okButton,
                          ],
                        );
                        showDialog(
                          context: context, builder: (BuildContext context) {
                          return alert;
                        },
                        );

                    }

                  } else {
                    Widget okButton = FlatButton(
                        child: Text("حسنًا",
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                color: const Color(0xff598270),
                                fontWeight: FontWeight.bold)),
                        onPressed: () {
                          Navigator.pop(context);
                        }
                    );
                    AlertDialog alert = AlertDialog(
                      content: Text(
                        "حدث خطأ، حاول مجددًا",
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                      ),
                      actions: [
                        okButton,
                      ],
                    );
                    showDialog(
                      context: context, builder: (BuildContext context) {
                      return alert;
                    },
                    );
                }

                },
            ),
          ),
              ),


          Transform.translate(
            offset: Offset(310.0, 180.0),
              child: Container(
                width: 60.0,
                height: 60.0,
                  child: Icon(
                    Icons.perm_identity_outlined,
                    size: 65.0,
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
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => generalGuide()));},
                child: Icon(
                    Icons.arrow_back_ios
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
