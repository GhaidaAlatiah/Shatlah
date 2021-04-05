import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shatlah2/generalGuide.dart';
import 'package:shatlah2/editProfile.dart';
import 'package:shatlah2/Register.dart';
import 'package:shatlah2/home_logout.dart';
import 'package:shatlah2/plantImage.dart';
import 'package:shatlah2/userColl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'user.dart';
import 'Plant.dart';

Plant first;
user logUser;
String email;
String name;
final _databaseRef =
    FirebaseDatabase.instance.reference(); //database reference object

class logIn extends StatefulWidget {
  logIn({
    Key key,
  }) : super(key: key);

  @override
  _logInState createState() => _logInState();
}

class _logInState extends State<logIn> {
  String _logEmail = '';
  String _logPassword = '';
  FirebaseAuth instance = FirebaseAuth.instance;

  var logInKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: logInKey,
      backgroundColor: const Color(0xfff5f5f5),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(0, 205),
            child: Container(
              width: 895.0,
              height: 1202.0,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.elliptical(50000.0, 35000.0)),
                color: const Color(0xffffffff),
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
            offset: Offset(100.0, 315.0),
            child: SizedBox(
              width: 202.0,
              height: 62.0,
              child: SingleChildScrollView(
                  child: Text(
                'تسجيل دخول',
                style: TextStyle(
                  fontFamily: 'Adobe Clean',
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff598270),
                  shadows: [
                    Shadow(
                      color: const Color(0x29000000),
                      offset: Offset(30, 3),
                      blurRadius: 10,
                    )
                  ],
                ),
                textAlign: TextAlign.left,
              )),
            ),
          ),
          Transform.translate(
            offset: Offset(70, 110.0),
            child: SizedBox(
              width: 259.0,
              height: 62.0,
              child: SingleChildScrollView(
                child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.topToBottom,
                              child: Register()));
                    },
                    child: Text(
                      'إنشاء حساب\n',
                      style: TextStyle(
                        fontFamily: 'Adobe Clean',
                        fontSize: 40,
                        color: const Color(0xff598270),
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: const Color(0x29000000),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          )
                        ],
                      ),
                      textAlign: TextAlign.center,
                    )),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(110.0, 609.0),
            child: Container(
              width: 193.0,
              height: 60.0,
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
              child: FlatButton(
                  child: Text(
                    'دخول',
                    style: TextStyle(
                      fontFamily: 'Adobe Clean',
                      fontSize: 30,
                      color: const Color(0xffffffff),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () async {
                    UserCredential _user;
                    try {
                      if (_logEmail == '' || _logPassword == ''){
                        Widget okButton = FlatButton(
                            child: Text("حسنًا",
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    color: const Color(0xff598270),
                                    fontWeight: FontWeight.bold)),
                            onPressed: () {
                              Navigator.pop(context);
                            });
                        AlertDialog alert = AlertDialog(
                          content: Text(
                            "ادخل الحقول المطلوبة!",
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                          ),
                          actions: [
                            okButton,
                          ],
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }
                      else {
                      _user = await instance.signInWithEmailAndPassword(
                          email: this._logEmail, password: this._logPassword);}

                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        Widget okButton = FlatButton(
                            child: Text("حسنًا",
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    color: const Color(0xff598270),
                                    fontWeight: FontWeight.bold)),
                            onPressed: () {
                              Navigator.pop(context);
                            });
                        AlertDialog alert = AlertDialog(
                          content: Text(
                            "اسم المستخدم غير صحيح",
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                          ),
                          actions: [
                            okButton,
                          ],
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      } else if (e.code == 'wrong-password') {
                        Widget okButton = FlatButton(
                            child: Text("حسنًا",
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    color: const Color(0xff598270),
                                    fontWeight: FontWeight.bold)),
                            onPressed: () {
                              Navigator.pop(context);
                            });
                        AlertDialog alert = AlertDialog(
                          content: Text(
                            "كلمة المرور خاطئة، حاول مجددًا",
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                          ),
                          actions: [
                            okButton,
                          ],
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      } else if (e.code == 'invalid-email') {
                        Widget okButton = FlatButton(
                            child: Text("حسنًا",
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    color: const Color(0xff598270),
                                    fontWeight: FontWeight.bold)),
                            onPressed: () {
                              Navigator.pop(context);
                            });
                        AlertDialog alert = AlertDialog(
                          content: Text(
                            "البريد الإلكتروني غير صحيح",
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                          ),
                          actions: [
                            okButton,
                          ],
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
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
                            });
                        AlertDialog alert = AlertDialog(
                          content: Text(
                            "ادخل الحقول المطلوبة!",
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                          ),
                          actions: [
                            okButton,
                          ],
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }
                    } // end catch

                    if (_user.user.emailVerified) {
                      email = _logEmail;
                      await _databaseRef
                          .orderByChild('email')
                          .equalTo(_logEmail)
                          .once()
                          .then((DataSnapshot snap) {
                        var key = snap.value.keys;
                        var data = snap.value;
                        for (var i in key) {
                          name = data[i]['name'];
                          logUser = new user(name, email);
                        } // end for
                      });


                      //load the plants from the database to the user


                      await _databaseRef
                          .orderByChild("email")
                          .equalTo(logUser.getEmail())
                          .once()
                          .then((DataSnapshot snap) {
                        var plantKey = snap.value.keys;
                        var plantData = snap.value;
                        var plantName;
                        var image;
                        var date;
                        var arabicName;
                        plantImage userPlant;

                        for (var i in plantKey) {

                          for (int j = 0; j < 50; j++) {
                            if (plantData[i]["ename" + j.toString()] != null)
                              plantName = plantData[i]["ename" + j.toString()];
                            else
                              continue;

                            if (plantData[i]["image" + j.toString()] != null)
                              image = plantData[i]["image" + j.toString()];

                            if (plantData[i]["date" + j.toString()] != null)
                              date = plantData[i]["date" + j.toString()];
                            if (plantData[i]["arname" + j.toString()] != null)
                              arabicName =
                                  plantData[i]["arname" + j.toString()];
                            userPlant = new plantImage(
                                plantName, image, date, arabicName);

                            if (plantData[i]["day" + j.toString()] != null) {
                              userPlant
                                  .setCHD(plantData[i]["day" + j.toString()]);
                            }
                            if (plantData[i]["picked" + j.toString()] != null) {
                              userPlant.setPicked(
                                  plantData[i]["picked" + j.toString()]);
                            }
                            logUser.userCollection.add(userPlant);
                          } //end first loop
                        } //end adding data
                      });
                      for (int i = 0; i < logUser.userCollection.length; i++) {
                        // logUser.userCollection.asMap()[i].scheduleAlarm(logUser.userCollection.asMap()[i].picked);
                      }
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => generalGuide()));
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
                          });
                      AlertDialog alert = AlertDialog(
                        content: Text(
                          "الرجاء التحقق من البريد الإلكتروني",
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                        ),
                        actions: [
                          okButton,
                        ],
                      );
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    }
                  }),
            ),
          ),
          Transform.translate(
            offset: Offset(410.8, 140.5),
            child: SvgPicture.string(
              _svg_7pjy8l,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(6.0, 226.0),
            child:
                // Adobe XD layer: 'شتلة بدون خلفيه' (shape)
                Container(
              width: 401.0,
              height: 362.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/images/Logo.png'),
                  fit: BoxFit.fill,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.15), BlendMode.dstIn),
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(49.0, 410.0),
            child: Container(
              width: 315.0,
              height: 47.0,
              child: TextFormField(
                textAlign: TextAlign.center,
                cursorColor: Colors.black38,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: "البريد الإلكتروني",
                  hintStyle: TextStyle(
                    color: Colors.black38,
                    fontSize: 17,
                    height: 0,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  setState(() {
                    this._logEmail = value;
                  });
                },
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(49.0, 474.0),
            child: Container(
              width: 315.0,
              height: 47.0,
              child: TextFormField(
                textAlign: TextAlign.center,
                cursorColor: Colors.black38,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: "كلمة المرور",
                  hintStyle: TextStyle(
                    color: Colors.black38,
                    fontSize: 17,
                    height: 0,
                  ),
                ),
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    this._logPassword = value;
                  });
                },
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(240.0, 540.0),
            child: FlatButton(
              child: Text(
                'نسيت كلمة المرور',
                style: TextStyle(
                  fontFamily: 'Adobe Clean',
                  fontSize: 16,
                  color: const Color(0xff598270),
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: const Color(0x29000000),
                      offset: Offset(0, 3),
                      blurRadius: 2,
                    )
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              onPressed: () async {
                String _forgotEmail;

                return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        'أدخل البريد الإلكتروني:',
                        style: TextStyle(
                            color: const Color(0xff598270),
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                      ),
                      content: TextFormField(
                        textAlign: TextAlign.center,
                        cursorColor: Colors.black38,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          hintText: "البريد الإلكتروني",
                          hintStyle: TextStyle(
                            color: Colors.black38,
                            fontSize: 17,
                            height: 0,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          setState(() {
                            _forgotEmail = value.toLowerCase();
                          });
                        },
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('إلغاء',
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: const Color(0xff598270),
                                  fontWeight: FontWeight.bold)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        FlatButton(
                          child: Text('ارسال',
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: const Color(0xff598270),
                                  fontWeight: FontWeight.bold)),
                          onPressed: () async {
                            await instance.sendPasswordResetEmail(
                                email: _forgotEmail);

                            Widget okButton = FlatButton(
                                child: Text("حسنًا",
                                    textAlign: TextAlign.right,
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                        color: const Color(0xff598270),
                                        fontWeight: FontWeight.bold)),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => logIn()));
                                });
                            AlertDialog alert = AlertDialog(
                              content: Text(
                                'تم إرسال رابط تغيير كلمة المرور للبريد الإلكتروني!',
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                              ),
                              actions: [
                                okButton,
                              ],
                            );
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_7pjy8l =
    '<svg viewBox="410.8 140.5 1.0 1.0" ><path transform="translate(-77.0, 101.0)" d="M 487.7835388183594 39.51798629760742" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
