import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:firebase_database/firebase_database.dart';

import 'Plant.dart';

FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();




class plantImage{
  String arabicPlant;
  String plantName;
  String image;
  String date;
  TimeOfDay picked = new TimeOfDay() ;
  List <int> chd = [] ;
  String alarmDays = '';
  var location;
  int serial;
  bool thereIsReminder = false;
  plantImage(String plantName, String image,String date,String arabicPlant){
    this.arabicPlant = arabicPlant;
    this.plantName = plantName;
    this.image = image;
    this.date = date;
    tz.initializeTimeZones();
    location = tz.getLocation("Asia/Kuwait");
  }

  String getPlantName (){
    return plantName;
  }

  String getImage(){
    return image;
  }

  void setPicked (String pickedString){
    int hour = int.parse(pickedString.substring(0 , pickedString.indexOf(':')))   ;
   int minutes = int.parse(pickedString.substring(pickedString.indexOf(':')+1 , pickedString.length));
   picked = TimeOfDay(hour: hour, minute: minutes);
  }

  void setCHD(String chdString){
    alarmDays = chdString;
    for(int i = 0 ; i<chdString.length ; i++) {
      chd.add(int.parse(chdString.substring(i,i+1)));
   }
  }

  void scheduleAlarm(TimeOfDay picked  ) async {
    Plant second ;
    thereIsReminder = true;
    var _databaseRef = FirebaseDatabase.instance.reference();
    await _databaseRef.orderByChild("ename").equalTo(this.plantName).once().then((DataSnapshot snap){

      var plantKey= snap.value.keys;
      var plantData= snap.value;

      for (var i in plantKey){
        second = new Plant(plantData[i]["arname"].toString(),
            plantName, plantData[i]["irrigation"].toString(),
            plantData[i]["sunlight"].toString(), plantData[i]["temp"]);
        second.serial = plantData[i]["serialnum"].toString();
        second.image = plantData[i]["URL"];
      } // end for
    }

    );





    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
    );
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics);

    List <bool> bolldays = [false,false,false,false,false,false,false];

    for (int i = 0 ; i<chd.length ; i++){
      bolldays[chd[i]] = true;
    }

    int count = 0;
    var weekday = DateTime.now().weekday;
    var x;
    for(int i = 0; i<chd.length;++i){
      int day = DateTime.now().day;
      int month = DateTime.now().month;

      if(bolldays[i]){
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
            matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
        print ((int.parse(second.serial))*100+i);
        count++;

      } // end if
      else{
        continue;
      }

    }//end loop



  }
  void setSerial (String serialS){
    this.serial = int.parse(serialS);
  }
}

