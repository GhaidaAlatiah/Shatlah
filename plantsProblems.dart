import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'logIn.dart';
import 'generalGuide.dart';
import 'package:page_transition/page_transition.dart';


final _databaseRef = FirebaseDatabase.instance.reference(); //database reference object
int selectedIndex = 0;
var check;

class plantsProblems extends StatefulWidget {
  plantsProblems({
    Key key,
  }) : super(key: key);

  @override
  _plantsProblemsState createState() => _plantsProblemsState();
}

class _plantsProblemsState extends State<plantsProblems> {
  int selectedIndex = 0;

  void plantLoading(){


    //if(check != null){
    _databaseRef.orderByChild('email').equalTo("zahaalluhaidan@gmail.com").once().then((DataSnapshot snap){
      var checkKey= snap.value.keys;
      var checkData= snap.value;
      int count=0;
      for(var i in checkKey){
        logUser.userImage.add(checkData[i]["Image0"].toString());
        logUser.userPlants.add(checkData[i]["EnName0"].toString());
        print(logUser.userImage.asMap()[0]);
        print(logUser.userPlants.asMap()[0]);

        // check= checkData[i]["EnName"];
      } // end for
    }
    );
    // } // end if
  } // end method


  @override
  Widget build(BuildContext context) {
    return Scaffold(
  // SingleChildScrollView(
      // physics: ScrollPhysics(),
      body: Stack(

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
            offset: Offset(0.0, -60.0),
            child: Container(
              height: 235,
              width: 380,
              child: SingleChildScrollView(
                child: Text("أشهر المشكلات وحلولها:"
                  ,maxLines: 100,
                  overflow: TextOverflow.visible,
                  textDirection: TextDirection.rtl,  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: 'plus',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff000000),
                  ),
                ),
              ),
            ),
          ),


    Transform.translate(
     offset: Offset(20.0, 220.0),
    child: Container(
      width: 365,
      color: Colors.white70,
      child: new SingleChildScrollView(
    child: RichText(
      maxLines: 500,
      overflow: TextOverflow.visible,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
    text: new TextSpan(
    style: new TextStyle(
    fontSize: 18.0,
    color: Colors.black,
    ),

    children: <TextSpan>[

      new TextSpan(text: " يشكو الكثير من محبي النباتات ومقتنييها من العديد من المشاكل التي تصيب نباتتاهم كذبولها أو تساقط أوراقها أو ضعف نموها وغيرها مما يؤثر على نباتاتهم."
          + "لذلك جمعنا لكم في شتله أشهر تلك المشاكل وأسبابها المتوقعة والحلول المقترحة لها من تجارب وخبرات مقتني النباتات ومحبيها .."+ "\n" "\n", style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold)),


      new TextSpan(text: " - تساقط الأوراق:"+ "\n" , style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
    new TextSpan(text: '''
 بسبب تعرض النبات للعديد من العوامل المؤثرة كتغير مفاجئ في درجة الحرارة، تعرضها لتيار قوي سواءً كان باردًا ام حار او جفاف الجذور'''
" وحل هذه المشكلة يكون بنقله إلى مكان مناسب بعيد عن التيارات ومصادر الحرارة وتوفير الرطوبة المناسبة والضوء حسب حاجته"
     + "\n" "\n"  ),

      new TextSpan(text: " - تحول أطراف الأوراق وحوافها إلى اللون الأسود:"+ "\n" , style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
      new TextSpan(text: 'ويحدث ذلك نتيجة جفاف الهواء المحيط او عدم الانتظام بالري.' +"\n"+
          "وحل هذه المشكلة التغير في اللون يكون بوضع الأصيص فوق حوض يحتوي على حصى متساوي الحجم ومبلل، رش الأوراق بالرذاذ بشكل متكرر (مرتين يومياً مثلاً) والانتظام بالري."
          + "\n" "\n"  ),


      new TextSpan(text: " - ذبول الأوراق:"+ "\n" , style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
      new TextSpan(text: 'نتيجة تعرضها للجفاف المفرط (العطش) او الإغراق (ري مفرط).' +"\n"+
          "ولمعالجة ذبول الاوراق بسبب العطش يتم وضع الأصيص في حوض ماء لمدة كافية لإنعاشه حتى يرتوي وتقدر تلك المدة بحسب حجم الاصيص، اما إذا كان سبب الذبول الري المفرط فتنقل النبتة إلى حوض يحتوي على تربة جافة كي تمتص الرطوبة الزائدة."
          + "\n" "\n"  ),


      new TextSpan(text: " - ظهور بقع سوداء على الأوراق:"+ "\n" , style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
      new TextSpan(text: 'تظهر تلك البقع نتيجة لتعرض الاوراق المباشر لأشعة الشمس اللاسعة،' +
          "وعند ظهورها يتم قطع الأجزاء السوداء لحل هذه المشكلة، كما يجب مراعاة التدرج في التعرض للضوء عند نقل النبتة من بيئة لأخرى."
          + "\n" "\n"  ),


      new TextSpan(text: " - تجعد والتفاف في حواف الأوراق:"+ "\n" , style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
      new TextSpan(text: "يصيب حواف الاوراق هذا التجعد بسبب التعرض للإضاءة الشديدة، وعند ملاحظته يتم نقل الأصيص إلى مكان اقل ضوءً."
          + "\n" "\n"  ),

      new TextSpan(text: " اصفرار الأوراق وتساقطها:"+ "\n" , style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
      new TextSpan(text: "يصيبها بسبب التعرض المباشر للتيار الهوائي او بسبب الري الزائد عن الحاجة، وعند ملاحظة اصفرار الاوراق يفضل ابعاد النبتة عن مصدر التيار وتقليل كمية الري."
          + "\n" "\n"  ),

    ],

    ),
    ),
    ),
    ),
      ),



          Transform.translate(
            offset: Offset(60.0, 90.0),
            child: Container(
              height: 55,
              width: 370,
              child: FlatButton(
                child: Text("أشهر المشكلات وحلولها:",
                  style: TextStyle(
                    fontFamily: 'plus',
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff0e0c0c),
                  ),
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                ),

                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => generalGuide())); },
              ),
            ),
          ),

          Transform.translate(
            offset: Offset(10.0, 65.0),
            child:
            Container(
              width: 30.0,
              height: 30.0,
              child: FlatButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => generalGuide()));},

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