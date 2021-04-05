import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:shatlah2/Register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shatlah2/editProfile.dart';
import 'package:shatlah2/logIn.dart';
import 'package:shatlah2/plantBeforeAdd.dart';
import 'package:shatlah2/userColl.dart';
import 'user.dart';
import 'package:image_picker/image_picker.dart';
import 'userCollByAlpha.dart';
import 'plantImage.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'Plant.dart';
import 'package:flutter/gestures.dart';
import 'plantsProblems.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_analytics/firebase_analytics.dart';


List <String> sortedName = new List();
List <String> sortedImage = new List();
List<String> sortDate = new List();
List <plantImage> sortedColl = new List();
var _databaseRef = FirebaseDatabase.instance.reference(); //database reference object
int selectedIndex = 0;
var check;
String finalr = '';
Plant second = new Plant("ArName", "EnName", "Irrigation", "Sunlight", "Temp");

class youmnak extends StatefulWidget {
  youmnak({
    Key key,
  }) : super(key: key);

  @override
  _youmnakState createState() => _youmnakState();
}

class _youmnakState extends State<youmnak> {
  var _Plantimages= [ "assets/images/plant1.jpeg",
    "assets/images/plant2.jpeg",
    "assets/images/plant3.jpeg",
    "assets/images/plant4.jpeg",
    "assets/images/plant5.jpeg" ];

  File stored;

  var databaseRef = FirebaseDatabase.instance.reference(); //database reference object
  void getPlantsData() async { //detect image, search plant , display description

    await _databaseRef.orderByChild("ename").equalTo(finalr).once().then((DataSnapshot snap){

      var plantKey= snap.value.keys;
      var plantData= snap.value;

      for (var i in plantKey){
        second = new Plant(plantData[i]["arname"].toString(),
            finalr, plantData[i]["irrigation"].toString(),
            plantData[i]["sunlight"].toString(), plantData[i]["temp"]);
        second.serial = plantData[i]["serialnum"].toString();
        second.image = plantData[i]["URL"];
      } // end for
    }

    );
    if(second.ArName == "ArName") {
      Widget okButton = FlatButton(
          child: Text("حسنًا"),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(
                    builder: (context) => userColl()));
          }
      );
      AlertDialog alert = AlertDialog(
        content: Text(
            "عذراً، تعذّر العثور على النبتة"),
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
    else{
      await Navigator.push(context, new MaterialPageRoute(builder: (context) => plantBeforeAdd()));}

  }// end get plants data



  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
 String imagePath;
  Future uploadImageToFirebase() async {
    String fileName = path.basename(stored.path);
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(stored);
    TaskSnapshot taskSnapshot = await uploadTask ;
    taskSnapshot.ref.getDownloadURL().then(
          (value) => imagePath = value,
    );
    await databaseRef.orderByChild("email").equalTo("ghkh_at@hotmail.com").once().then((DataSnapshot snap){

      var plantKey= (snap.value.keys).toString();
      var plantData= snap.value;
      plantKey = plantKey.substring(1,21);
      databaseRef.child(plantKey).update({'image4': imagePath});

    }

    );

  }


  void _onItemTapped(int index) async {

    setState(() {
      selectedIndex = index;

      switch (selectedIndex)  {
        case 0:
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => youmnak()));
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
                                    .path); //if old version use : stored=image
                              });
                              uploadImageToFirebase();
                              final url =
                                  'http://192.168.100.55:8000/name';

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
                              uploadImageToFirebase();
                              final url =
                                  'http://192.168.100.55:8000/name';

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

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Stack(
        //SingleChildScrollView(
        // physics: ScrollPhysics(),
        //  child: Column(
        //mainAxisSize: MainAxisSize.min,
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Transform.translate(
            offset: Offset(0.0, -44.0),
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
            offset: Offset(310.0,85),
            child: Container(
              width: 60.0,
              height: 60.0,
              child: FlatButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => editProfile()));
                },
                child: Icon(
                  Icons.perm_identity_outlined,
                  color: Colors.black87,
                  size: 65.0,
                ),
              ),
            ),
          ),




          Transform.translate(
            offset: Offset(130.0, 200.0),
            child: Container(
              height: 50,
              width: 250,

              child: Text("أشهر النباتات الصبورة:",
                style: TextStyle(
                  fontFamily: 'plus',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff000000),
                ),
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
            ),
          ),

          Transform.translate(
            offset: Offset(0.0, -30.0),
            child: Container(

              child: Swiper(
                itemBuilder: (BuildContext context, int index){
                  return new Image.asset(_Plantimages[index], fit: BoxFit.cover,);
                },

                layout: SwiperLayout.STACK,
                itemCount: 5,
                itemWidth: 200.0,
                itemHeight: 250.0,

                autoplay: true,
                autoplayDisableOnInteraction: true,
              ),
            ),
          ),


          Transform.translate(
            offset: Offset(10.0, 590.0),
            child: Container(
              width: 380,
              child: RichText(
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),

                    text:
                    " يشكو الكثير من محبي النباتات ومقتنييها من العديد من المشاكل التي تصيب نباتتاهم كذبولها أو تساقط أوراقها أو ضعف نموها وغيرها مما يؤثر على نباتاتهم."
                        + "لذلك جمعنا لكم في شتله أشهر تلك المشاكل وأسبابها المتوقعة والحلول المقترحة لها من تجارب وخبرات مقتني النباتات ومحبيها  ",

                    children: <TextSpan>[
                      TextSpan(
                        text: 'للمزيد..',
                        style: TextStyle(color: Colors.blueAccent, fontSize: 17.5, fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()

                          ..onTap = () async {

                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => plantsProblems())); },

                      ),
                    ],
                  )
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
                  Navigator.pop(context);  },
                child: Icon(
                    Icons.arrow_back_ios
                ),
              ),
            ),
          ),


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


        ],
      ),
    );
    // );
  }
}