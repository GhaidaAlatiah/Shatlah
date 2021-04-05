import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shatlah2/daysCheck.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'generalGuide.dart';
import 'userCollByAlpha.dart';
import 'userColl.dart';
import 'logIn.dart';
import 'package:page_transition/page_transition.dart';

class setAlarm extends StatefulWidget {
  setAlarm({
    Key key,
  }) : super(key: key);


  @override
  _setAlarmState createState() => _setAlarmState();
}

class _setAlarmState extends State<setAlarm> {
  // var d = [Day.sunday, Day.monday , Day.tuesday , Day.wednesday , Day.thursday , Day.friday , Day.saturday];
  bool isSwitched = true;
  TimeOfDay time;
  TimeOfDay picked;
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  var now;
  var location;
  var databaseRef = FirebaseDatabase.instance.reference(); //database reference object


// Time ----------- Time ----------- Time ----------- Time -----------

  @override
  void initState () {
    super.initState();
    time = TimeOfDay.now();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    iniFun();
    tz.initializeTimeZones();
    location = tz.getLocation("Asia/Kuwait");
    now = tz.TZDateTime.now(location);
  }
  Future selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }}

  Future <Null> selectTime (BuildContext context) async {

    picked = await showTimePicker(
        context: context,
        initialTime: time
    );

    if (picked != null){
      setState(() {
        time = picked;
      });
    }
  }
// Time ----------- Time ----------- Time ----------- Time -----------

  void iniFun() async{

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('icon_logo');

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(0.0, 655),
            child:
            // Adobe XD layer: 'zlb5IHRjrk' (shape)
            Container(
              width: 412.5,
              height: 210,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/images/plantBackground.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(-1.0, -264.0),
            child: Container(
              width: 413.0,
              height: 998.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(53.0),
                color: const Color(0xffffffff),
              ),
            ),
          ),
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
            offset: Offset(79.0, 185.0),
            child: Container(
              width: 254.0,
              height: 161.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(23.0),
                color: const Color(0xefffffff),
              ),

            ),
          ),
          Transform.translate(
            offset: Offset(180,215),
            child: IconButton(
              icon: Icon(Icons.alarm),
              iconSize: 40,
              onPressed: (){
                selectTime(context);
                print(time);
              },
            ),
          ),
          Transform.translate(
              offset: Offset(169,270),
              child: Text (
                '${time.hour}:${time.minute}' , style: TextStyle(fontSize: 30),
              )
          ),
          Transform.translate(
            offset: Offset(0.5, 395.5),
            child: SvgPicture.string(
              _svg_1qvsd0,
              allowDrawingOutsideViewBox: true,
            ),
          ),

          Transform.translate(
              offset: Offset(0.5,395),

              child: ButtonTheme(
                minWidth: 412,
                height: 50,
                child: FlatButton(


                  onPressed: () {
                    // textBuild = "اليوم:  ";
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => daysCheck()));
                  },

                ),
              )

          ),

          Transform.translate(
            offset: Offset(7,407),
            child: Icon(Icons.arrow_back_ios),
          ),
          Transform.translate(
            offset: Offset(335,407),
            child: Text(
              "اليوم",
              style: TextStyle(
                fontFamily: 'plus',
                fontSize: 20,
                color: const Color(0xffffffff),),
            ),
          ),
          Transform.translate(
            offset: Offset(335.0, 457.0),
            child: Text(
              "ذكرني", // Days
              style: TextStyle(
                fontFamily: 'plus',
                fontSize: 20,
                color: const Color(0xffffffff),
              ),
              textAlign: TextAlign.right,
            ),
          ),
          Transform.translate(
            offset: Offset(1,457),
            child: Switch(
                value: isSwitched,
                onChanged: (val){
                  setState(() {
                    isSwitched = val;
                  });
                  if (val == false){
                    cancelAlarm();
                  }
                //  else scheduleAlarm(picked);
                }

            ),
          ),
          Transform.translate(
            offset: Offset(330.0, 60.0),
            child: Container(
              width: 70.0,
              height: 41.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(21.0),
                color: const Color(0x6a000d06),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(350.0, 65.0),
            child: SizedBox(
              width: 34.0,
              height: 24.0,
              child: SingleChildScrollView(
                  child: Text(
                    "حفظ",
                    style: TextStyle(
                      fontFamily: 'plus',
                      fontSize: 19,
                      color: const Color(0xffffffff),
                      shadows: [
                        Shadow(
                          color: const Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        )
                      ],
                    ),
                    textAlign: TextAlign.right,
                  )),
            ),
          ),
          Transform.translate(
            offset: Offset(18.0, 65.0),
            child:
            // Adobe XD layer: 'image' (shape)
            Container(
              width: 30.0,
              height: 30.0,
              child: FlatButton(
                onPressed: () {
                  Navigator.pop(context, PageTransition(type: PageTransitionType.leftToRight));
                },
                child: Icon (
                    Icons.arrow_back_ios
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(700,1000),
            child: Container(
              width: 1600,
              height: 4000,
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.all(Radius.elliptical(9999, 9999)),
                color: const Color(0xfff5f5f5) ,

              ),

            ),
          ),

          Transform.translate(
            offset: Offset(340.0,61.0),
            child: FlatButton (
              onPressed: () async{
                int count = 0;
                for (int i = 0 ; i<chd.length ; i++){
                  if(chd[i])
                    count++;
                }
                if(count == 0){
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
                      "الرجاء اختيار الأيام أولاً!",
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
                  try{
               await scheduleAlarm( picked);
               Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => userColl()));}
                  on NoSuchMethodError catch (e){
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
                        "الرجاء اختيار الساعة!",
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
                }

              },
            ),
          )

        ],
      ),
    );
  }
  void scheduleAlarm(TimeOfDay picked  ) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
    ); // Specification from the system to send notification
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics);
    int count = 0; // مدري وش هي
     var weekday = DateTime.now().weekday; // get the week day of today
     var x; // the difference between days
     for(int i = 0; i<chd.length;++i){ // loop for scheduling the alarms
       int day = DateTime.now().day;
       int month = DateTime.now().month;
       if(chd[i]){
         if(weekday< i+1){
           x = (i+1) - weekday;
           day = day+x;
         }
         if(weekday > i+1) {
           x = weekday - (i+1);
           day = day - x + 7;
         }

         if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
           if(day>31) {
             day = day - 31;
             month = month+1;
           }
         }
         if (month == 2) {
           if(day>29) {
             day = day - 29;
             month = month+1;
           }
         }

         if (month == 2) {
           if(day>29) {
             day = day - 29;
             month = month+1;
           }
         }

         if (month == 4 || month == 6 || month == 9 || month == 11) {
           if(day>30) {
             day = day - 30;
             month = month+1;
           }
         }
         await _flutterLocalNotificationsPlugin.zonedSchedule((int.parse(second.serial))*100+i, "تذكير سقاية", "حان وقت سقاية نبتة ${second.ArName}",tz.TZDateTime(location,2021,month,day,picked.hour,picked.minute,0,0,0),
             platformChannelSpecifics, uiLocalNotificationDateInterpretation: null, androidAllowWhileIdle: true ,
             matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime); // Schedule local alarm
         count++; // delete

       } // end if
       else{
         continue;
       }

     }//end loop

    String dayIndex = '' ;
     for (int i = 0; i<chd.length ; i++){ // create string that has all days chosen by the user
       if (chd[i] == true){
         dayIndex = dayIndex + i.toString();
       }
     }
    String ind = plantIndex.toString();
    await databaseRef.orderByChild("email").equalTo(logUser.getEmail()).once().then((DataSnapshot snap){ // store notification to the database

      var plantKey= (snap.value.keys).toString();
      var plantData= snap.value;
      plantKey = plantKey.substring(1,21);
      databaseRef.child(plantKey).update({'picked'+ind: picked.hour.toString()+':'+picked.minute.toString() , 'day'+ind: dayIndex});

      logUser.userCollection.asMap()[plantIndex].picked = picked;
      logUser.userCollection.asMap()[plantIndex].alarmDays = dayIndex;

    }

    );
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => userColl()));


  }

  void cancelAlarm () async {
    var count = 0;
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
    );
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics);

    for (int i = 0; i < 7; i++) {
      await _flutterLocalNotificationsPlugin.cancel(
          (int.parse(second.serial)) * 100 + i);
    }


    await databaseRef.orderByChild("email").equalTo(logUser.getEmail())
        .once()
        .then((DataSnapshot snap) {
      var key = snap.value.keys;

      databaseRef.child(key.toString().substring(1, key
          .toString()
          .length - 1)).child("picked" + plantIndex.toString()).remove();
      databaseRef.child(key.toString().substring(1, key
          .toString()
          .length - 1)).child("day" + plantIndex.toString()).remove();
    });
  }
}

const String _svg_1qvsd0 =
    '<svg viewBox="0.5 395.5 412.0 100.0" ><path transform="translate(0.5, 395.5)" d="M 0 0 L 412 0" fill="none" stroke="#000000" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(0.5, 445.5)" d="M 0 0 L 412 0" fill="none" stroke="#000000" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(0.5, 495.5)" d="M 0 0 L 412 0" fill="none" stroke="#000000" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';


