import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shatlah2/generalGuide.dart';
import 'package:shatlah2/home_logout.dart';
import 'package:shatlah2/logIn.dart';
import 'package:shatlah2/userColl.dart';
import 'package:shatlah2/generalGuide.dart';
import 'package:firebase_database/firebase_database.dart';

class Register extends StatefulWidget {
  Register({
    Key key,
  }) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final databaseRef = FirebaseDatabase.instance.reference(); //database reference object


  String _username = '' ;
  String _RegEmail = '';
  String _RegPassword = '';
  @override
  var RegKey= GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    return Scaffold(
      key: RegKey,


      body: Stack(
        children: <Widget>[

         Transform.translate(
            offset: Offset(0, -200.0),
            child: Container(
              width: 895.0,
              height: 1202.0,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
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
            offset: Offset(77.0, 136.0),
            child: SizedBox(
              width: 259.0,
              height: 62.0,
              child: SingleChildScrollView(
                  child: Text(
                'إنشاء حساب\n',
                style: TextStyle(
                  fontFamily: 'Adobe Clean',
                  fontSize: 43,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff598270),
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
    offset: Offset(49.0, 265.0),
    child: Container(
    width: 315.0,
    height: 47.0,
       child: TextFormField (
            textAlign: TextAlign.center,
            cursorColor: Colors.black38,
            style: TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration (
              hintText: " الاسم",
              hintStyle: TextStyle(color: Colors.black38, fontSize: 17, height: 0,
              ),
            ),
            onChanged: (value) {
              setState(() {
                this._username = value;
              });
            },
          ),
    ),
    ),


          Transform.translate(
            offset: Offset(49.0, 329.0),
            child: Container(
              width: 315.0,
              height: 47.0,
              child: TextFormField (
                textAlign: TextAlign.center,
                cursorColor: Colors.black38,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration (
                  hintText: "البريد الإلكتروني",
                  hintStyle: TextStyle(color: Colors.black38, fontSize: 17, height: 0,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  setState(() {
                    this._RegEmail = value;
                  });
                },
              ),
            ),
          ),

          Transform.translate(
            offset: Offset(49.0, 393.0),
            child: Container(
              width: 315.0,
              height: 47.0,
              child: TextFormField (
                textAlign: TextAlign.center,
                cursorColor: Colors.black38,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration (
                  hintText: "كلمة المرور",
                  hintStyle: TextStyle(color: Colors.black38, fontSize: 17, height: 0,
                  ),
                ),
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    this._RegPassword = value;
                  });
                },
              ),
            ),
          ),


          Transform.translate(
            offset: Offset(110.0, 490.0),
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
            child: FlatButton(child: Text( 'تسجيل',
              style: TextStyle(
                fontFamily: 'Adobe Clean',
                fontSize: 30,
                color: const Color(0xffffffff),
              ),
              textAlign: TextAlign.center,
            ),

                onPressed: () async {

            try {
              if (_RegEmail == '' || _RegPassword == '' || _username == '' ){
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
                    "ادخل الحقول المطلوبة.",
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

              else {
                UserCredential _user;
                if (_RegEmail != null && _RegPassword != null &&
                    _username != null) {
                  _user =
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: this._RegEmail, password: this._RegPassword);

                  await _user.user.sendEmailVerification();
                  if (_username.isNotEmpty) {
                    await databaseRef.push().set({
                      'name': _username,
                      'email': _RegEmail
                    });
                  }

                  Widget okButton = FlatButton(
                      child: Text("حسنًا",
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              color: const Color(0xff598270),
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => logIn()));
                      }
                  );
                  AlertDialog alert = AlertDialog(
                    content: Text(
                      "تم التسجيل بنجاح، تحقق من البريد الإلكتروني",
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
                } //end if
              }

           } on FirebaseAuthException catch (e) {

              /*   if (e.code == 'weak-password') {
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
                  } else if (e.code == 'email-already-in-use') {
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
                        "البريد الإلكتروني مستخدم مسبقًا!",
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
                        }
                    );
                    AlertDialog alert = AlertDialog(
                      content: Text(
                        "تحقق من صحة البريد الإلكتروني!",
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

                  else if (e.code == 'IOException'){
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
                        "حدث خطأ، تحقق من صحة المدخلات.",
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
                  }; */

                switch(e.code){
                    case 'weak-password':
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
                      break;

                    case 'email-already-in-use':
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
                          "البريد الإلكتروني مستخدم مسبقًا!",
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
                  break;

                    case 'invalid-email':
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
                          "تحقق من صحة البريد الإلكتروني!",
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
                      break;

                    default:
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
                          "حدث خطأ، تحقق من صحة المدخلات.",
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
                  }// end switch

                } // end catch

            }
            ),
            ),
                      ),


          Transform.translate(
            offset: Offset(90.0, 670.0),
            child: FlatButton(child: Text('تسجيل دخول',
              style: TextStyle(
                fontFamily: 'Adobe Clean',
                fontSize: 40,
                color: const Color(0xff598270),
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: const Color(0x29000000),
                    offset: Offset(0, 5),
                    blurRadius: 6,
                  )
                ],
              ),
              textAlign: TextAlign.left,
            ),
              onPressed: (){
                Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: logIn()));

              },
          ),
          ),

        ],
      ),
    );
  }
}