import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shatlah2/logIn.dart';
import 'package:shatlah2/plantImage.dart';
import 'package:shatlah2/userColl.dart';
import 'dart:io';
import 'Plant.dart';
import 'plantAfterAdd.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'generalGuide.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';

File stored;
class plantBeforeAdd extends StatefulWidget {
  final VoidCallback irregation;
  final VoidCallback light;
  final VoidCallback temp;
  bool pressed = false;

  plantBeforeAdd({
    Key key,
    this.irregation,
    this.light,
    this.temp,
  }) : super(key: key);

  @override
  _plantBeforeAddState createState() => _plantBeforeAddState();
}

class _plantBeforeAddState extends State<plantBeforeAdd> {
  bool valuefirst = false;
  File _selectedItem;

  var _databaseRef = FirebaseDatabase.instance.reference(); //database reference object
  void initState (){
    super.initState();
   // getPlantsData();
  }


  void getPlantsData() async {
    //detect image, search plant , display description
    Plant first = new Plant("ArName", "EnName", "Irrigation", "Sunlight", "Temp");
    await _databaseRef.orderByChild("ename").equalTo(finalr).once().then((
        DataSnapshot snap) {
      try {
        var plantKey = snap.value.keys;
        var plantData = snap.value;

        for (var i in plantKey) {
          first = new Plant(plantData[i]["arname"].toString(),
              finalr, plantData[i]["irrigation"].toString(),
              plantData[i]["sunlight"].toString(), plantData[i]["temp"]);
          first.serial = plantData[i]["serialnum"].toString();
          first.image = plantData[i]["URL"];
        }
      } on NoSuchMethodError catch (e) {
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
            "عذرًا، تعذر العثور على النبتة.",
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
    }
    );
    if(first.ArName=="ArName"){
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
          "عذرًا، تعذر العثور على النبتة.",
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
    }else{
      second.image = first.image;
      second.serial = first.serial;
      second.ArName = first.ArName;
      second.EnName = first.EnName;
      second.Irrigation = first.Irrigation;
      second.Sunlight = first.Sunlight;
      second.Temp = first.Temp;
      await Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => plantBeforeAdd()));}
  }


  String imagePath;
  Future addToCollection(String ind , String date) async {
    String fileName = path.basename(stored.path); // Path of the picture from the device
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('uploads/$fileName'); // get the reference of the fireStorage
    UploadTask uploadTask = firebaseStorageRef.putFile(stored); // upload picture to fireStorage
    TaskSnapshot taskSnapshot = await uploadTask ;
    taskSnapshot.ref.getDownloadURL().then ((value){ // Get the url of the picture to save it in user collection
      setState(() {
        imagePath = value; // Store the url in a variable
         _databaseRef.orderByChild("email").equalTo(logUser.getEmail()).once().then((DataSnapshot snap){ // Get instance of current user
          var plantKey= (snap.value.keys).toString();
          plantKey = plantKey.substring(1,21);
          second.image = imagePath; //Add the image to the object
          _databaseRef.child(plantKey).update({'ename'+ind: second.EnName,  'date'+ind: date , 'arname'+ind: second.ArName , 'image'+ind: imagePath}); //store the added plant to user collection
          logUser.userCollection.add(new  plantImage(second.EnName, imagePath, date , second.ArName));
          second.addedDate = date;
          var navigationResult =  Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => plantAfterAdd()));
         });
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(700.0, 1000.0),
            child: Container(
              width: 1440.0,
              height: 3040.0,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                color: const Color(0xfff5f5f5),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0.0, -51.0),
            child: Container(
              width: 412.0,
              height: 426.0,
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
            offset: Offset(90, 50),
            child: Container(
              width: 200,
              height: 240,
              child: Image.file(stored),
              ),
            ),

          Transform.translate(
            offset: Offset(300.0, 425.0),
            child: GestureDetector(
              onTap: () => widget.irregation?.call(),
              child: SizedBox(
                width: 90.0,
                height: 87.0,
                child: Stack(
                  children: <Widget>[
                    Pinned.fromSize(
                      bounds: Rect.fromLTWH(0.0, 0.0, 89.6, 87.1),
                      size: Size(89.6, 87.1),
                      pinLeft: true,
                      pinRight: true,
                      pinTop: true,
                      pinBottom: true,
                      child: Stack(
                        children: <Widget>[
                          Pinned.fromSize(
                            bounds: Rect.fromLTWH(-0.4, -0.1, 90.0, 87.0),
                            size: Size(89.6, 87.1),
                            pinLeft: true,
                            pinRight: true,
                            pinTop: true,
                            pinBottom: true,
                            child: Stack(
                              children: <Widget>[
                                Pinned.fromSize(
                                  bounds: Rect.fromLTWH(0.0, 0.0, 90.0, 87.0),
                                  size: Size(90.0, 87.0),
                                  pinLeft: true,
                                  pinRight: true,
                                  pinTop: true,
                                  pinBottom: true,
                                  child: Stack(
                                    children: <Widget>[
                                      Pinned.fromSize(
                                        bounds:
                                            Rect.fromLTWH(0.0, 0.0, 90.0, 87.0),
                                        size: Size(90.0, 87.0),
                                        pinLeft: true,
                                        pinRight: true,
                                        pinTop: true,
                                        pinBottom: true,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: const AssetImage(
                                                  'assets/images/irreg.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Pinned.fromSize(
                                        bounds:
                                            Rect.fromLTWH(0.0, 0.0, 90.0, 87.0),
                                        size: Size(90.0, 87.0),
                                        pinLeft: true,
                                        pinRight: true,
                                        pinTop: true,
                                        pinBottom: true,
                                        child: SvgPicture.string(
                                          _svg_yllvc6,
                                          allowDrawingOutsideViewBox: true,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Pinned.fromSize(
                            bounds: Rect.fromLTWH(0.0, 0.0, 89.6, 87.1),
                            size: Size(89.6, 87.1),
                            pinLeft: true,
                            pinRight: true,
                            pinTop: true,
                            pinBottom: true,
                            child: SvgPicture.string(
                              _svg_gyqdkn,
                              allowDrawingOutsideViewBox: true,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(298.8, 535.0),
            child: GestureDetector(
              onTap: () => widget.light?.call(),
              child: SizedBox(
                width: 90.0,
                height: 87.0,
                child: Stack(
                  children: <Widget>[
                    Pinned.fromSize(
                      bounds: Rect.fromLTWH(0.0, 0.0, 89.6, 87.1),
                      size: Size(89.6, 87.1),
                      pinLeft: true,
                      pinRight: true,
                      pinTop: true,
                      pinBottom: true,
                      child: Stack(
                        children: <Widget>[
                          Pinned.fromSize(
                            bounds: Rect.fromLTWH(-0.3, -0.7, 90.0, 87.6),
                            size: Size(89.6, 87.1),
                            pinLeft: true,
                            pinRight: true,
                            pinTop: true,
                            pinBottom: true,
                            child: Stack(
                              children: <Widget>[
                                Pinned.fromSize(
                                  bounds: Rect.fromLTWH(0.0, 0.0, 90.0, 87.6),
                                  size: Size(90.0, 87.6),
                                  pinLeft: true,
                                  pinRight: true,
                                  pinTop: true,
                                  pinBottom: true,
                                  child: Stack(
                                    children: <Widget>[
                                      Pinned.fromSize(
                                        bounds:
                                            Rect.fromLTWH(0.0, 0.0, 100, 100),
                                        size: Size(89.6, 87.1),
                                        pinLeft: true,
                                        pinRight: true,
                                        pinTop: true,
                                        pinBottom: true,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: const AssetImage(
                                                  'assets/images/light.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Pinned.fromSize(
                                        bounds:
                                            Rect.fromLTWH(0.0, 0.0, 90.0, 87.6),
                                        size: Size(90.0, 87.6),
                                        pinLeft: true,
                                        pinRight: true,
                                        pinTop: true,
                                        pinBottom: true,
                                        child: Container(
                                          decoration: BoxDecoration(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Pinned.fromSize(
                            bounds: Rect.fromLTWH(0.0, 0.0, 89.6, 87.1),
                            size: Size(89.6, 87.1),
                            pinLeft: true,
                            pinRight: true,
                            pinTop: true,
                            pinBottom: true,
                            child: SvgPicture.string(
                              _svg_63oojt,
                              allowDrawingOutsideViewBox: true,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(305.8, 650.0),
            child: SizedBox(
              width: 90.0,
              height: 87.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 89.6, 87.1),
                    size: Size(89.6, 87.1),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child: Stack(
                      children: <Widget>[
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(0.0, 0.0, 89.6, 87.1),
                          size: Size(89.6, 87.1),
                          pinLeft: true,
                          pinRight: true,
                          pinTop: true,
                          pinBottom: true,
                          child: Stack(
                            children: <Widget>[
                              Pinned.fromSize(
                                bounds: Rect.fromLTWH(0.0, 0.0, 89.6, 87.1),
                                size: Size(89.6, 87.1),
                                pinLeft: true,
                                pinRight: true,
                                pinTop: true,
                                pinBottom: true,
                                child: Stack(
                                  children: <Widget>[
                                    Pinned.fromSize(
                                      bounds: Rect.fromLTWH(0.0, 0.0, 90, 90),
                                      size: Size(89.6, 87.1),
                                      pinLeft: true,
                                      pinRight: true,
                                      pinTop: true,
                                      pinBottom: true,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: const AssetImage(
                                                'assets/images/temp.png'),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Pinned.fromSize(
                                      bounds:
                                          Rect.fromLTWH(0.0, 0.0, 89.6, 87.1),
                                      size: Size(89.6, 87.1),
                                      pinLeft: true,
                                      pinRight: true,
                                      pinTop: true,
                                      pinBottom: true,
                                      child: Container(
                                        decoration: BoxDecoration(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(0.0, 0.0, 89.6, 87.1),
                          size: Size(89.6, 87.1),
                          pinLeft: true,
                          pinRight: true,
                          pinTop: true,
                          pinBottom: true,
                          child: SvgPicture.string(
                            _svg_lg2cqj,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(-30.0, 414.0),
            child: SizedBox(
              width: 346.0,
              height: 67.0,
              child: SingleChildScrollView(
                  child: Text.rich(
                TextSpan(
                  style: TextStyle(
                    fontFamily: 'Adobe Clean',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff000000),
                  ),
                  children: [
                    TextSpan(
                      text: 'الري\n',
                    ),
                    TextSpan(
                      text: '\n',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.right,
              )),
            ),
          ),
          Transform.translate(
          offset: Offset(0.0, 450.0),
            child: Container(
              width: 300,
              height: 60,
              //color: Colors.blue,
              child: Text(
                second.getIrrigation(),
                style: TextStyle(
                  fontSize: 18
                ),
                textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(-20.0, 540.0),
            child: SizedBox(
              width: 336.0,
              child: Text(
                'الاضاءة\n',
                style: TextStyle(
                  fontFamily: 'Adobe Clean',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff000000),
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0.0, 567.0),
            child: Container(
              width: 300,
              height: 60,
              //color: Colors.blue,
              child: Text(
                second.getSunlight(),
                style: TextStyle(
                    fontSize: 18
                ),
                textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(-30, 650.0),
            child: SizedBox(
              width: 355.0,
              child: Text(
                'درجة الحرارة\n',
                style: TextStyle(
                  fontFamily: 'Adobe Clean',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff000000),
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0.0, 680.0),
            child: Container(
              width: 300,
              height: 60,
              //color: Colors.blue,
              child: Text(
                second.getTemp(),
                style: TextStyle(
                    fontSize: 18
                ),
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
            ),
          ),

          Transform.translate(
            offset: Offset(0,300) ,
            child: Container(

              width: 500,
              height: 50,
              child: Text(
                second.getArname(),
                style: TextStyle (
                  fontSize: 30,

                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
            ),
          ),
          Transform.translate(
              offset: Offset(25.0, 315.0),
              child:
                  // Adobe XD layer: 'image' (shape)
                  Container(
                width: 35.0,
                height: 35.0,
                child: FloatingActionButton(
                  backgroundColor: Color(0xFFFFFFFF),

                  onPressed: () async {

                    String ind = logUser.userCollection.length.toString();
                    String date = DateTime.now().day.toString()+'/'+DateTime.now().month.toString()+"/"+DateTime.now().year.toString();
                   await addToCollection(ind , date);

                  },
                  child: new Icon(Icons.add, color: Colors.black, size: 35),
                ),
              )),
          Transform.translate(
            offset: Offset(0, 750),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.party_mode_outlined ),
                  label: '',
                ),
                BottomNavigationBarItem(

                  icon: Icon(Icons.library_add_outlined),
                  label: '',
                ),

              ],

              iconSize: 35,
              unselectedFontSize: 12,
              selectedFontSize: 14,
              selectedItemColor: Colors.black87,
              unselectedItemColor: Colors.black38,

              currentIndex: selectedIndex,
              onTap: _onItemTapped,
            ),
          ),
          Transform.translate(
              offset: Offset(700,1000),
              child: Container(
                width: 1440,
                height: 3040,
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.all(Radius.elliptical(9999, 9999)),
                  color: const Color(0xfff5f5f5),
                ),
              )
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
    Navigator.pop(context, PageTransition(type: PageTransitionType.leftToRight)); },
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
  void _onItemTapped(int index) async {

    setState(() {
      selectedIndex = index;

      switch (selectedIndex)  {
        case 0:
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => generalGuide()));
          break;

        case 1:
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(

                  height: 120,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                            leading: Icon(Icons.photo_library),
                            title: Text('اختر صورة من الألبوم'),
                            onTap: () async {
                              var image = await ImagePicker()
                                  .getImage(source: ImageSource.gallery);
                              if (image == null) {
                                print('user cancel the operation');
                                return; //this cancel the operation if there is no image
                              }
                              setState(() {
                                stored = File(image
                                    .path);
                              });

                              final url =
                                  'https://molten-avenue-309217.uc.r.appspot.com/name'; //The url of the API in Google App Engine

                              var request = http.MultipartRequest(
                                'POST',
                                Uri.parse(url),
                              );
                              //send request to the API

                              Map<String, String> headers = {
                                "Content-type": "multipart/form-data"
                              };
                              request.files.add(
                                http.MultipartFile(
                                  'name',
                                  image.readAsBytes().asStream(),
                                  File(image.path)
                                      .lengthSync(), //if old version use: image.lengthSync()
                                  filename: "name",
                                  contentType: MediaType('image', 'jpeg'),
                                ),
                              );
                              request.headers.addAll(headers);
                              var response = await request.send();
                              response.stream.listen((value) {
                                print("sending...");
                              }, onDone: () async {
                                print('done');
                                print(response.statusCode);
                                //you can use get method here
                                var res = await http.get(Uri.parse(url));
                                final decoded = json.decode(res.body)
                                as Map<String, dynamic>;

                                setState(() {
                                  finalr = decoded['name'];
                                });
                                getPlantsData();

                              },
                                  onError: (e) {
                                    print('error');
                                  });
                            }),

                        ListTile(
                            leading: Icon(Icons.photo_camera),
                            title: Text('إلتقط صورة'),
                            onTap: () async {
                              var image = await ImagePicker()
                                  .getImage(source: ImageSource.camera);
                              if (image == null) {
                                print('user cancel the operation');
                                return; //this cancel the operation if there is no image
                              }
                              setState(() {
                                stored = File(image
                                    .path); //if old version use : stored=image
                              });

                              final url =
                                  'https://molten-avenue-309217.uc.r.appspot.com/name';

                              var request = http.MultipartRequest(
                                'POST',
                                Uri.parse(url),
                              );
                              Map<String, String> headers = {
                                "Content-type": "multipart/form-data"
                              };
                              request.files.add(
                                http.MultipartFile(
                                  'name',
                                  image.readAsBytes().asStream(),
                                  File(image.path)
                                      .lengthSync(), //if old version use: image.lengthSync()
                                  filename: "name",
                                  contentType: MediaType('image', 'jpeg'),
                                ),
                              );
                              request.headers.addAll(headers);
                              var response = await request.send();
                              response.stream.listen((value) {
                                print("sending...");
                              }, onDone: () async {
                                print('done');
                                print(response.statusCode);
                                //you can use get method here
                                var res = await http.get(Uri.parse(url));
                                final decoded = json.decode(res.body)
                                as Map<String, dynamic>;

                                setState(() {
                                  finalr = decoded['name'];
                                });

                                getPlantsData();
                              },
                                  onError: (e) {
                                    print('error');
                                  });
                            }),
                      ],
                    ),
                    //_buildBottomNavigationMenu(),
                  ),
                );
              });
          break;

        case 2:

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => userColl()));
          break;


      }

    });
  }
}

const String _svg_yllvc6 =
    '<svg viewBox="0.0 0.0 90.0 87.0" ><path transform="translate(0.0, 0.0)" d="M 0 0 L 90 0 L 90 87 L 0 87 Z" fill="none" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_gyqdkn =
    '<svg viewBox="0.0 0.0 89.6 87.1" ><path transform="translate(0.0, 451.0)" d="M 0 -451 L 89.6131591796875 -451 L 89.6131591796875 -363.8573608398438 L 0 -363.8573608398438 L 0 -451 Z" fill="none" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_63oojt =
    '<svg viewBox="0.0 0.0 89.6 87.1" ><path transform="translate(0.0, 173.0)" d="M 0 -173 L 89.61000061035156 -173 L 89.61000061035156 -85.86000061035156 L 0 -85.86000061035156 L 0 -173 Z" fill="none" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_lg2cqj =
    '<svg viewBox="0.0 0.0 89.6 87.1" ><path transform="translate(0.0, 213.0)" d="M 0 -213 L 89.61000061035156 -213 L 89.61000061035156 -125.8600006103516 L 0 -125.8600006103516 L 0 -213 Z" fill="none" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_r6ue4k =
    '<svg viewBox="325.1 746.0 48.9 57.6" ><path transform="translate(322.13, 744.0)" d="M 15.22143173217773 1.99999988079071 C 9.015900611877441 1.99999988079071 3.764879703521729 4.073709487915039 3.764879703521729 4.073709487915039 C 3.247751712799072 4.258774280548096 2.924858093261719 4.837719440460205 3.001110076904297 5.443141460418701 C 3.001110076904297 5.443140983581543 3.650538921356201 10.12092590332031 5.743738651275635 14.83352375030518 C 6.790338039398193 17.1898250579834 8.210693359375 19.56317138671875 10.15277576446533 21.40679359436035 C 12.09485626220703 23.25041770935059 14.60098838806152 24.53692245483398 17.61689186096191 24.53692245483398 C 20.1121711730957 24.53692245483398 21.78291130065918 24.02827644348145 21.78291130065918 24.02827644348145 C 22.37729263305664 23.84460067749023 22.72701644897461 23.15265655517578 22.56404113769531 22.48277473449707 C 22.40106391906738 21.81289482116699 21.7871036529541 21.41874885559082 21.19272232055664 21.6024284362793 C 21.19272613525391 21.6024284362793 19.84532356262207 22.0328197479248 17.61689186096191 22.0328197479248 C 15.14031600952148 22.0328197479248 13.19540500640869 21.06586456298828 11.5761661529541 19.52871704101562 C 9.956925392150879 17.99156951904297 8.678186416625977 15.85025215148926 7.722597599029541 13.6988525390625 C 6.198945045471191 10.26852416992188 5.652718544006348 7.408810615539551 5.431287288665771 6.147419452667236 C 6.622335433959961 5.728013515472412 10.3217887878418 4.50410270690918 15.22143173217773 4.50410270690918 C 20.07744407653809 4.50410270690918 22.85245895385742 6.834229946136475 24.247802734375 9.864446640014648 C 25.42420768737793 12.41919326782227 25.52311897277832 15.55592823028564 24.73383903503418 18.23753929138184 C 23.39937591552734 16.51373481750488 21.87869071960449 14.98522758483887 20.35952186584473 13.65972709655762 C 16.3589916229248 10.16920280456543 12.37465190887451 8.06462287902832 12.37465190887451 8.06462287902832 C 12.17066097259521 7.95019006729126 11.9403829574585 7.909212589263916 11.71503353118896 7.947243213653564 C 11.22010231018066 8.017390251159668 10.8273229598999 8.45069408416748 10.75451278686523 9.006863594055176 C 10.68170261383057 9.563033103942871 10.9467134475708 10.10571765899658 11.40258026123047 10.33396530151367 C 11.40258121490479 10.33396530151367 15.19480800628662 12.32140159606934 18.97084808349609 15.61605644226074 C 22.74689102172852 18.91071128845215 26.33081436157227 23.44414520263672 26.33081436157227 28.13656997680664 L 26.33081436157227 30.79717826843262 C 26.32791900634766 30.84929656982422 26.32791900634766 30.90156745910645 26.33081436157227 30.95368385314941 C 26.3291072845459 31.03203392028809 26.33081436157227 31.10950088500977 26.33081436157227 31.18844413757324 L 26.33081436157227 32.04922866821289 L 11.88861656188965 32.04922866821289 C 11.85391902923584 32.04739379882812 11.81916332244873 32.04739379882812 11.78446578979492 32.04923248291016 C 11.21193885803223 32.11004257202148 10.77520179748535 32.65317535400391 10.77767944335938 33.30127716064453 L 10.77767753601074 40.8135871887207 C 10.77767753601074 41.50492095947266 11.27497673034668 42.06550598144531 11.88850593566895 42.06563949584961 L 13.20785522460938 42.06563949584961 L 16.36708641052246 58.61618804931641 C 16.48020362854004 59.18473815917969 16.92632865905762 59.5902099609375 17.44330787658691 59.5943603515625 L 37.4401969909668 59.59435653686523 C 37.95717620849609 59.5902099609375 38.40330123901367 59.18473052978516 38.51641845703125 58.61618804931641 L 41.6756477355957 42.06563949584961 L 42.99488830566406 42.06563949584961 C 43.60830307006836 42.06563949584961 44.10570526123047 41.50517272949219 44.1058235168457 40.81371307373047 L 44.1058235168457 33.3012809753418 C 44.1058235168457 32.60994338989258 43.60852432250977 32.04936218261719 42.9949951171875 32.04922866821289 L 28.55269050598145 32.04922866821289 L 28.55269050598145 31.18844413757324 C 28.55269050598145 31.12226867675781 28.5511302947998 31.05846786499023 28.55269050598145 30.9928092956543 C 28.55721855163574 30.92770004272461 28.55721855163574 30.86229133605957 28.55269050598145 30.79717826843262 C 28.64590835571289 28.83771133422852 29.44115257263184 27.10608673095703 30.67041778564453 25.51508712768555 C 31.98141098022461 23.81830215454102 33.79547500610352 22.35611152648926 35.63492202758789 21.17203521728516 C 39.31381607055664 18.80388069152832 43.02960586547852 17.61151313781738 43.02960586547852 17.61151313781738 C 43.63356781005859 17.48185920715332 44.02992248535156 16.82494735717773 43.91488265991211 16.14426612854004 C 43.79983901977539 15.46358108520508 43.21696853637695 15.01688385009766 42.61299896240234 15.1465368270874 C 42.54262161254883 15.15209674835205 42.47287368774414 15.16519737243652 42.40469741821289 15.18566417694092 C 42.40470123291016 15.18566417694092 38.48279190063477 16.4326057434082 34.52398300170898 18.9809455871582 C 33.74737167358398 19.48086166381836 32.98504257202148 20.05685234069824 32.23267364501953 20.66338920593262 C 32.35147476196289 19.68002128601074 32.56482315063477 18.47738265991211 33.03115844726562 17.25937461853027 C 34.0583381652832 14.57653522491455 35.96762084960938 12.01640892028809 40.77301406860352 12.01640892028809 C 45.57796478271484 12.01640892028809 48.44309997558594 13.14284992218018 49.45222091674805 13.58147239685059 C 49.21709442138672 14.68628978729248 48.69932174682617 16.77508354187012 47.4039306640625 19.29395866394043 C 45.67948150634766 22.64711952209473 42.96230697631836 25.78897285461426 38.3775520324707 25.78897285461426 C 35.69488143920898 25.78897285461426 33.93379592895508 24.84993362426758 33.93379592895508 24.84993362426758 C 33.57199478149414 24.64474105834961 33.1397819519043 24.67770004272461 32.8057975769043 24.93595314025879 C 32.47181701660156 25.1942024230957 32.28899383544922 25.6368236541748 32.32865905761719 26.09110641479492 C 32.36832809448242 26.54539108276367 32.62420272827148 26.93935394287109 32.99644088745117 27.1192798614502 C 32.99644088745117 27.1192798614502 35.2255744934082 28.29307556152344 38.3775520324707 28.29307556152344 C 43.8912239074707 28.29307556152344 47.36725616455078 24.33016586303711 49.3133544921875 20.5460090637207 C 51.25945281982422 16.76185417175293 51.84767913818359 12.99457454681396 51.84767913818359 12.99457454681396 C 51.94248962402344 12.43063163757324 51.68495178222656 11.86625385284424 51.2227783203125 11.62514209747314 C 51.2227783203125 11.62514305114746 46.97854232788086 9.512307167053223 40.77301406860352 9.512307167053223 C 35.20779037475586 9.512307167053223 32.25116729736328 12.96860122680664 30.98286628723145 16.28120803833008 C 29.71457099914551 19.59381675720215 29.87192916870117 22.81535148620605 29.87192916870117 22.81535148620605 C 29.87174797058105 22.82839012145996 29.87174797058105 22.84143447875977 29.87192726135254 22.8544750213623 C 29.57649803161621 23.18134689331055 29.27529907226562 23.5206470489502 29.00400924682617 23.87176895141602 C 28.70754814147949 24.25547027587891 28.43093299865723 24.66862487792969 28.17080497741699 25.08469581604004 C 27.79427528381348 23.47887229919434 27.16023445129395 21.95457458496094 26.33081436157227 20.5460090637207 C 27.87709808349609 16.91875457763672 27.94223403930664 12.41627788543701 26.22666168212891 8.690648078918457 C 24.46861267089844 4.872771263122559 20.73603057861328 1.99999988079071 15.22143173217773 1.99999988079071 Z M 12.99955558776855 34.5533332824707 L 41.88394927978516 34.5533332824707 L 41.88394927978516 39.5615348815918 L 12.99955558776855 39.5615348815918 L 12.99955558776855 34.5533332824707 Z M 15.46444988250732 42.06563949584961 L 39.4190559387207 42.06563949584961 L 36.53755950927734 57.09025192260742 L 18.34594535827637 57.09025192260742 L 15.46444988250732 42.06563949584961 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
