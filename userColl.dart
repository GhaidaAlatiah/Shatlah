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
import 'package:shatlah2/plantImage.dart';
import 'package:shatlah2/userCollByAlpha.dart';
import 'Plant.dart';
import 'generalGuide.dart';
import 'setReminder.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';

int plantIndex;
bool check = false;
final _databaseRef = FirebaseDatabase.instance.reference(); //database reference object

String selectedItem;
class userColl extends StatefulWidget {
  userColl({
    Key key,
  }) : super(key: key);

  @override
  _userCollState createState() => _userCollState();
}

class _userCollState extends State<userColl> {
  @override

  List<String> images = ["https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png"]; //will be deleted

  var arr = new List(logUser.userCollection.length);



  void sortPlantByAlpha() async{

    int static = logUser.sortedColl.length; // length of the sorting collection
    if (static != 0){ // remove all plants to avoid conflict
      for(int i = 0 ; i< static ; i++){
        logUser.sortedColl.removeLast();
      }
    }

    for(int i = 0; i<logUser.userCollection.length ; ++i){ //Get the serial number of all user's plants from the dataset
      await setSerial(i);
    }//end set serial
    int temp;
    for(int i = 0 ; i<logUser.userCollection.length ; i++){ //sort serial numbers incrementally
      for (int j = i+1 ; j<logUser.userCollection.length ; j++){
        if(arr[i] > arr[j]){
          temp = arr[i];
          arr[i] = arr[j];
          arr[j] = temp;
        }
      }
    } // end sorting the array
    for(int i = 0 ; i<logUser.userCollection.length ; i++){ // Match the serial number with its plant object
      for(int j = 0 ; j<logUser.userCollection.length ; j++){
        if(arr[i] == logUser.userCollection.asMap()[j].serial )
          logUser.sortedColl.add(logUser.userCollection.asMap()[j]);
      }} //add in sorted;

  }

  void setSerial(int index) async{
    await _databaseRef.orderByChild("ename").equalTo(logUser.userCollection.asMap()[index].getPlantName()).once().then((DataSnapshot snap){

      var plantKey= snap.value.keys;
      var plantData= snap.value;

      for (var i in plantKey){
        logUser.userCollection.asMap()[index].setSerial(plantData[i]['serialnum'].toString());
      }// end for
      arr[index] =  logUser.userCollection.asMap()[index].serial;
    }

    );
  }


  void initState (){
    super.initState();
    //loadPlantList();


  }


  void getPlantsData() async {
    //detect image, search plant , display description

    second = new Plant("ArName", "EnName", "Irrigation", "Sunlight", "Temp");
    await _databaseRef.orderByChild("ename").equalTo(finalr).once().then((
        DataSnapshot snap) {
      try {
        var plantKey = snap.value.keys;
        var plantData = snap.value;

        for (var i in plantKey) {
          second = new Plant(plantData[i]["arname"].toString(),
              finalr, plantData[i]["irrigation"].toString(),
              plantData[i]["sunlight"].toString(), plantData[i]["temp"]);
          second.serial = plantData[i]["serialnum"].toString();
          second.image = plantData[i]["URL"];
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
    if(second.ArName=="ArName"){
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
    }else

    await Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.leftToRight, child: plantBeforeAdd()));
  }


   void UserReminder (int index) async {
    await _databaseRef.orderByChild("ename").equalTo(logUser.userCollection.asMap()[index].getPlantName()).once().then((DataSnapshot snap){

      var plantKey= snap.value.keys;
      var plantData= snap.value;

      for (var i in plantKey){
        second = new Plant(plantData[i]["arname"].toString(),
            logUser.userCollection.asMap()[index].plantName, plantData[i]["irrigation"].toString(),
            plantData[i]["sunlight"].toString(), plantData[i]["temp"]);
        second.serial = plantData[i]["serialnum"].toString();
        second.image = plantData[i]["URL"];
        second.addedDate = logUser.userCollection.asMap()[index].date;
      } // end for
    }

    );
  }

  void getUserPlantsData(int index) async { // Display user's plant

    await _databaseRef.orderByChild("ename").equalTo(logUser.userCollection.asMap()[index].getPlantName()).once().then((DataSnapshot snap){

      var plantKey= snap.value.keys;
      var plantData= snap.value;

      for (var i in plantKey){
        second = new Plant(plantData[i]["arname"].toString(),
            logUser.userCollection.asMap()[index].plantName, plantData[i]["irrigation"].toString(),
            plantData[i]["sunlight"].toString(), plantData[i]["temp"]);
        second.serial = plantData[i]["serialnum"].toString();
        second.image = logUser.userCollection.asMap()[index].image;
        second.addedDate = logUser.userCollection.asMap()[index].date;
      } // end for
    }

    );

    Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context) =>
            plantAfterAdd()));

  }// end get plants data

  void toSetReminder(int index) async { // Display user's plant

    await _databaseRef.orderByChild("ename").equalTo(logUser.userCollection.asMap()[index].getPlantName()).once().then((DataSnapshot snap){

      var plantKey= snap.value.keys;
      var plantData= snap.value;

      for (var i in plantKey){
        second = new Plant(plantData[i]["arname"].toString(),
            logUser.userCollection.asMap()[index].plantName, plantData[i]["irrigation"].toString(),
            plantData[i]["sunlight"].toString(), plantData[i]["temp"]);
        second.serial = plantData[i]["serialnum"].toString();
        second.image = plantData[i]["URL"];
        second.addedDate = logUser.userCollection.asMap()[index].date;
      } // end for
    }

    );

    Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context) =>
            setAlarm()));

  }// end get plants data

  void deletePlant (int index) async { //bring information of the selected plant to display it

    await _databaseRef.orderByChild("email").equalTo(logUser.getEmail()).once().then((DataSnapshot snap){
      var plant = logUser.userCollection.asMap()[index].getPlantName();
      var key = snap.value.keys;

      List <plantImage> temp = new List ();
      var staticLength = logUser.userCollection.length;

      for(int i = index ; i< staticLength ; i++ ){
        _databaseRef.child(key.toString().substring(1, key.toString().length - 1)).child("ename"+i.toString()).remove();
        _databaseRef.child(key.toString().substring(1, key.toString().length - 1)).child("image"+i.toString()).remove();
        _databaseRef.child(key.toString().substring(1, key.toString().length - 1)).child("date"+i.toString()).remove();
        _databaseRef.child(key.toString().substring(1, key.toString().length - 1)).child("arname"+i.toString()).remove();
        _databaseRef.child(key.toString().substring(1, key.toString().length - 1)).child("day"+i.toString()).remove();
        _databaseRef.child(key.toString().substring(1, key.toString().length - 1)).child("picked"+i.toString()).remove();

      }// end deleting from the database
      int staticIndex = index;
      for (int i = staticIndex+1 ; i< staticLength; i++ ){
        print(logUser.userCollection.asMap()[i].plantName);
        _databaseRef.child(key.toString().substring(1, key.toString().length - 1)).update({'ename'+(index).toString(): logUser.userCollection.asMap()[i].plantName,  'date'+(index).toString(): logUser.userCollection.asMap()[i].date , 'arname'+(index).toString(): logUser.userCollection.asMap()[i].arabicPlant , 'image'+(index).toString(): logUser.userCollection.asMap()[i].image});
        if(logUser.userCollection.asMap()[i].alarmDays != '')
          _databaseRef.child(key.toString().substring(1, key.toString().length - 1)).update({'day'+(index).toString(): logUser.userCollection.asMap()[i].alarmDays, 'picked'+(index).toString(): logUser.userCollection.asMap()[i].picked.hour.toString()+':'+logUser.userCollection.asMap()[i].picked.minute.toString() });

        index++;
      }

      logUser.userCollection.removeAt(staticIndex);

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
          "تم حذف النبتة بنجاح",
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

    });
  }// end get plants data

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
  }//end navigation bar

  Widget build(BuildContext context) {
    return Scaffold(

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


              Transform.translate( // start the collection transform
                offset: Offset(0, 250),
                child: Container(
                  height: 440,
                  width: 400,
                  //color: Colors.black,
                  child: GridView.builder(
                    itemCount: logUser.userCollection.length+1,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 50,
                      mainAxisSpacing: 50,),
                    itemBuilder: (BuildContext context, int index) {
                      if(logUser.userCollection.length > 0 && index < logUser.userCollection.length ) {
                        return Stack(
                            children: <Widget>[
                        InkWell(
                        child: Image.network(logUser.userCollection.asMap()[index].getImage()),
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
                      title: Text('عرض الوصف'),
                      onTap: () async {
                      getUserPlantsData(i);
                      //Navigator.push(context, MaterialPageRoute(
                      // builder: (BuildContext context) =>
                      //  plantAfterAdd()));
                      }),

                      ListTile(
                      leading: Icon(Icons.alarm),
                      title: Text('إضافة/تعديل التذكير'),
                      onTap: () async {
                      toSetReminder(i);
                      plantIndex = i;

                      }),

                      ListTile(
                      leading: Icon(Icons.delete_forever_outlined),
                      title: Text('حذف من المجموعة',
                      style: TextStyle(color: Colors.red),),
                      onTap: () async {
                     await deletePlant(index);
                      }),


                      ],
                      ),
                      //_buildBottomNavigationMenu(),
                      ),
                      );
                      });
                      },

                      ),

                              Transform.translate(
                                offset: Offset (0,136),
                                child: Container(
                                  width: 200,
                                  height: 30,

                                  decoration: new BoxDecoration(
                                      color: Color(0x29000000).withOpacity(0.5),
                                      borderRadius: new BorderRadius.only(
                                        topLeft: const Radius.circular(10.0),
                                        topRight: const Radius.circular(10.0),
                                        bottomLeft: const Radius.circular(10.0),
                                        bottomRight: const Radius.circular(10.0),
                                      )
                                  ),
                                  child: Text(
                                    logUser.userCollection.asMap()[index].arabicPlant,
                                    style: TextStyle(
                                      fontFamily: 'Adobe Clean',
                                      fontSize: 20,
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),)


                              )
                            ],);

                      }
                      else{
                        return Text(
                          " ",
                          style: TextStyle(
                            fontFamily: 'Adobe Clean',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff000000),
                          ),
                          textAlign: TextAlign.center,
                        );
                      }
                    },
                  ),
                ),
              ),


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
                offset: Offset(50.0, 100.0),
                child: Container(
                  height: 40,
                  width: 270,
                  child: Text("أهلًا، ${logUser.getName()}",
                    style: TextStyle(
                      fontFamily: 'plus',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff0e0c0c),
                    ),
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ),



              Transform.translate(
                offset: Offset(290.0, 200.0),
                child: Text(
                  'مجموعتي',
                  style: TextStyle(
                    fontFamily: 'plus',
                    fontSize: 30,
                    color: const Color(0xff000000),
                    shadows: [
                      Shadow(
                        color: const Color(0x29000000),
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      )
                    ],
                  ),
                  textAlign: TextAlign.right,
                ),
              ),


              Transform.translate( // sort code
                offset: Offset(20.0, 217.0),
                child: Container(
                  width: 60.0,
                  height: 60.0,
                  child: FlatButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(

                              height: 120,
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                        leading: Icon(Icons.sort_by_alpha),
                                        title: Text('تصنيف بحسب الاسم'),
                                        onTap: () async {
                                          await sortPlantByAlpha();
                                          await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => userCollByAlpha()));

                                        }),

                                    ListTile(
                                        leading: Icon(Icons.date_range_outlined),
                                        title: Text('تصنيف بحسب التاريخ'),
                                        onTap: () async {
                                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => userColl()));
                                        }),


                                  ],
                                ),
                                //_buildBottomNavigationMenu(),
                              ),
                            );
                          });
                    },
                    child: Icon(
                      Icons.sort,
                      color: Colors.black87,
                      size: 30.0,
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
  }
}
