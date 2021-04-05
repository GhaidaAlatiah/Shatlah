import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shatlah2/editProfile.dart';
import 'package:shatlah2/logIn.dart';
import 'package:shatlah2/plantAfterAdd.dart';
import 'package:shatlah2/plantBeforeAdd.dart';
import 'package:shatlah2/userCollByAlpha.dart';
import 'Plant.dart';
import 'generalGuide.dart';
import 'setReminder.dart';
import 'package:http/http.dart' as http;

class trial extends StatefulWidget {
  trial({
    Key key,
  }) : super(key: key);

  @override
  _trialState createState() => _trialState();
}

class _trialState extends State<trial> {
  @override
  List<String> images = ["https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png","https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png"
  ,"https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png"
  ,"https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png"]; //will be deleted

  Widget build(BuildContext context) {
    return Scaffold(
      body:
    Transform.translate(
      offset: Offset(0, 200),
      child: Container(
        height: 400,
        width: 400,
        child: GridView.builder(
          itemCount: 5,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 50,
            mainAxisSpacing: 50,),
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              children: <Widget>[
                InkWell(
                  child: Image.network(images[index])
                  ,
                  onTap: () {
                    var i = index;
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(

                            height: 195,
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                      leading: Icon(Icons.wb_incandescent_outlined),
                                      title: Text('عرض الوصف'),),

                                  ListTile(
                                      leading: Icon(Icons.alarm),
                                      title: Text('إضافة/تعديل التذكير'),
                                      ),

                                  ListTile(
                                      leading: Icon(Icons.delete_forever_outlined),
                                      title: Text('حذف من المجموعة',
                                        style: TextStyle(color: Colors.red),),),


                                ],
                              ),
                              //_buildBottomNavigationMenu(),
                            ),
                          );
                        });
                  },
                ),

                Transform.translate(
                  offset: Offset (50,130),
                  child: Text(
                    " كلام عربي",
                    style: TextStyle(
                      fontFamily: 'Adobe Clean',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff000000),
                    ),
                    textAlign: TextAlign.center,
                  ),

                )
              ],
            );
          },
        ),
      ),
    ),
    );
  }
}



