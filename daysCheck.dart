import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import "setReminder.dart";
import 'package:page_transition/page_transition.dart';


var chd = [false,false,false,false,false,false,false];
var week = new List(7);
var textBuild = "اليوم ";
class daysCheck extends StatefulWidget {
  daysCheck({
    Key key,
  }) : super(key: key);

  @override
  _daysCheckState createState() => _daysCheckState();
}

class _daysCheckState extends State<daysCheck> {


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
                    'حفظ\n',
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
            offset: Offset(350,65),
            child: FlatButton(
                onPressed: () {
                  if (chd[0])
                    week[0] = "الاثنين";
                  else week[0] = "null";
                  if (chd[1])
                    week[1] = "الثلاثاء";
                  else week[1] = "null";
                  if (chd[2])
                    week[2] = "الأربعاء";
                  else week[2] = "null";
                  if (chd[3])
                    week[3] = "الخميس";
                  else week[3] = "null";
                  if (chd[4])
                    week[4] = "الجمعة";
                  else week[4] = "null";
                  if (chd[5])
                    week[5] = "السبت";
                  else week[5] = "null";
                  if (chd[6])
                    week[6] = "الأحد";
                  else week[6] = "null";
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => setAlarm()));
                }
            ),
          ),
          Transform.translate(
            offset: Offset(0.5, 173.5),
            child: SvgPicture.string(
              _svg_5nf2sv,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(324.0, 230.0),
            child: Text(
              'الإثنين',
              style: TextStyle(
                fontFamily: 'plus',
                fontSize: 21,
                color: const Color(0xffffffff),
              ),
              textAlign: TextAlign.right,
            ),
          ),
          Transform.translate(
            offset: Offset(328.0, 182.0),
            child: Text(
              'الأحد',
              style: TextStyle(
                fontFamily: 'plus',
                fontSize: 21,
                color: const Color(0xffffffff),
              ),
              textAlign: TextAlign.right,
            ),
          ),
          Transform.translate(
            offset: Offset(316.0, 282.0),
            child: Text(
              'الثلاثاء',
              style: TextStyle(
                fontFamily: 'plus',
                fontSize: 21,
                color: const Color(0xffffffff),
              ),
              textAlign: TextAlign.right,
            ),
          ),
          Transform.translate(
            offset: Offset(0.5, 320.5),
            child: SvgPicture.string(
              _svg_1577cv,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(312.0, 330.0),
            child: SizedBox(
              width: 56.0,
              height: 26.0,
              child: SingleChildScrollView(
                  child: Text(
                    'الأربعاء\n',
                    style: TextStyle(
                      fontFamily: 'plus',
                      fontSize: 21,
                      color: const Color(0xffffffff),
                    ),
                    textAlign: TextAlign.right,
                  )),
            ),
          ),
          Transform.translate(
            offset: Offset(312.0, 378.0),
            child: Text(
              'الخميس',
              style: TextStyle(
                fontFamily: 'plus',
                fontSize: 21,
                color: const Color(0xffffffff),
              ),
              textAlign: TextAlign.right,
            ),
          ),
          Transform.translate(
            offset: Offset(315.0, 428.0),
            child: Text(
              'الجمعة',
              style: TextStyle(
                fontFamily: 'plus',
                fontSize: 21,
                color: const Color(0xffffffff),
              ),
              textAlign: TextAlign.right,
            ),
          ),
          Transform.translate(
            offset: Offset(0.5, 516.5),
            child: SvgPicture.string(
              _svg_btzc1l,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(330.0, 475.0),
            child: Text(
              'السبت',
              style: TextStyle(
                fontFamily: 'plus',
                fontSize: 21,
                color: const Color(0xffffffff),
              ),
              textAlign: TextAlign.right,
            ),
          ),
          Transform.translate(
              offset: Offset(40.0, 186.0),
              child: Container (
                  width: 25,
                  height: 25,
                  child: Checkbox (
                    value: chd[6],
                    onChanged: (val){
                      setState ((){
                        chd[6] = val; });},)
              )
          ),
          Transform.translate(
              offset: Offset(40.0, 333.0),
              child: Container (
                  width: 25,
                  height: 25,
                  child: Checkbox (
                    value: chd[2],
                    onChanged: (val){
                      setState ((){
                        chd[2] = val; });},)
              )
          ),
          Transform.translate(
              offset: Offset(40.0, 236.0),
              child: Container (
                  width: 25,
                  height: 25,
                  child: Checkbox (
                    value: chd[0],
                    onChanged: (val){
                      setState ((){
                        chd[0] = val; });},)
              )
          ),
          Transform.translate(
              offset: Offset(40.0, 284.0),
              child: Container (
                  width: 25,
                  height: 25,
                  child: Checkbox (
                    value: chd[1],
                    onChanged: (val){
                      setState ((){
                        chd[1] = val; });},)
              )
          ),
          Transform.translate(
              offset: Offset(40.0, 383.0),
              child: Container (
                  width: 25,
                  height: 25,
                  child: Checkbox (
                    value: chd[3],
                    onChanged: (val){
                      setState ((){
                        chd[3] = val; });},)
              )
          ),
          Transform.translate(
              offset: Offset(40.0, 431.0),
              child: Container (
                  width: 25,
                  height: 25,
                  child: Checkbox (
                    value: chd[4],
                    onChanged: (val){
                      setState ((){
                        chd[4] = val; });},)
              )
          ),
          Transform.translate(
              offset: Offset(40.0, 480.0),
              child: Container (
                  width: 25,
                  height: 25,
                  child: Checkbox (
                    value: chd[5],
                    onChanged: (val){
                      setState ((){
                        chd[5] = val; });},)
              )
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
            offset: Offset(18.0, 65.0),
            child:
            // Adobe XD layer: 'image' (shape)
            Container(
              width: 30.0,
              height: 30.0,
              child: FlatButton(
                onPressed: () {
                  Navigator.pop(context, PageTransition(type: PageTransitionType.leftToRight)); },
                child: Icon (
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

const String _svg_5nf2sv =
    '<svg viewBox="0.5 173.5 412.0 98.0" ><path transform="translate(0.5, 173.5)" d="M 0 0 L 412 0" fill="none" stroke="#000000" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(0.5, 222.5)" d="M 0 0 L 412 0" fill="none" stroke="#000000" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(0.5, 271.5)" d="M 0 0 L 412 0" fill="none" stroke="#000000" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_1577cv =
    '<svg viewBox="0.5 320.5 412.0 147.0" ><path transform="translate(0.5, 320.5)" d="M 0 0 L 412 0" fill="none" stroke="#000000" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(0.5, 369.5)" d="M 0 0 L 412 0" fill="none" stroke="#000000" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(0.5, 418.5)" d="M 0 0 L 412 0" fill="none" stroke="#000000" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(0.5, 467.5)" d="M 0 0 L 412 0" fill="none" stroke="#000000" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_btzc1l =
    '<svg viewBox="0.5 516.5 412.0 1.0" ><path transform="translate(0.5, 516.5)" d="M 0 0 L 412 0" fill="none" stroke="#000000" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
