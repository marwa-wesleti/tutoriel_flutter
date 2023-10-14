import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

//colors
const Color kPrimaryColor = Color.fromARGB(255, 12, 45, 113); //#0c2d71 en hex
const Color kSecondaryColor = Color(0xFF6789CA);
const Color kTextBlackColor = Color(0xFF313131);
const Color kTextWhiteColor = Color(0xFFFFFFFF);
const Color kContainerColor = Color(0xFF777777);
const Color kOtherColor = Color(0xFFF4F6F7);
const Color kTextLightColor = Color(0xFFA5A5A5);
const Color kcardColor = Color.fromARGB(71, 199, 197, 197);
const Color kmatColor = Color.fromARGB(96, 199, 197, 197);
const Color kColor = Color.fromARGB(65, 199, 197, 197);
const Color kErrorBorderColor = Color(0xFFE74C3C);
const Color black = Colors.black;
const Color white = Colors.white;
const kCardColor = Color(0xFF282B30);
const kHourColor = Color(0xFFF5C35A);
const kBGColor = Color(0xFF343537);

const kTextColor = Color(0xFF6C7174);

const kCalendarDay = TextStyle(
  color: kTextColor,
  fontSize: 16.0,
);

//validation for mobile
const String mobilePattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
// Toast
addToast(String txt) {
  Fluttertoast.showToast(
      msg: txt,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Color.fromARGB(255, 95, 92, 92),
      textColor: Colors.white);
}

// alertDialog
addAlertDialog(
    String titre, String contenu, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        titre,
        style: TextStyle(fontSize: 30),
      ),
      content: Text(contenu, style: TextStyle(fontSize: 20)),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed:()  {
           
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

// select date
Future<String?> selectDate(BuildContext context) async {
  String? date;
  DateTime? time = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2001),
      lastDate: DateTime(2100));
  if (time != null) return date = DateFormat('yyyy-MM-dd').format(time);
  return date;
}

// url php
const String url = "http://172.16.122.150/eparent";

// widget

// color
Color kprimaryO = Colors.orange;
Color kprimaryB = Color.fromARGB(255, 46, 85, 155);
Color kprimaryG = Color.fromARGB(255, 106, 205, 0);
Color kprimaryG2 = Color.fromARGB(255, 140, 181, 97);


Color colorFontTextField = Color.fromARGB(99, 209, 208, 208);

Color red = Colors.red;

Widget addText(String txt, Color colorText, bool isBold, double sizeText,
    isUnderline, String fontFamilyType) {
  return Text(
    txt,
    style: TextStyle(
        color: colorText,
        fontWeight: isBold == true ? FontWeight.bold : FontWeight.normal,
        fontSize: sizeText,
        decoration: isUnderline == true
            ? TextDecoration.underline
            : TextDecoration.none,
        fontFamily: fontFamilyType),
  );
}

Widget addTextFiel(Color colorFont, TextInputType inputType, double widthEdit,
    String hintText, TextEditingController txtController) {
  return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: 65,
      decoration: BoxDecoration(
        color: colorFont,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: widthEdit,
        child: TextFormField(
          controller: txtController,
          keyboardType: inputType,
          decoration:
              InputDecoration(border: InputBorder.none, hintText: hintText),
          validator: (value) {
            if (value!.isEmpty) {
              return "champ obligatoire";
            }
          },
        ),
      ));
}

ButtonStyle addButtonStyle(double radius, Color btnColor) {
  return ButtonStyle(
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
      backgroundColor: MaterialStateProperty.all(btnColor),
      padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(40, 10, 40, 10)));
}

Widget addTextFieldWithIcon(
    Color colorFont,
    Color colorIcon,
    IconData iconType,
    TextInputType inputType,
    double widthEdit,
    String hintText,
    TextEditingController txtController) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20),
    padding: EdgeInsets.only(left: 15),
    height: 65,
    decoration: BoxDecoration(
      color: colorFont,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        Icon(
          iconType,
          size: 27,
          color: colorIcon,
        ),
        SizedBox(
          width: 15,
        ),
        Container(
          width: widthEdit,
          child: TextFormField(
            controller: txtController,
            keyboardType: inputType,
            decoration:
                InputDecoration(border: InputBorder.none, hintText: hintText),
            validator: (value) {
              if (value!.isEmpty) {
                return "champ obligatoire";
              }
            },
          ),
        ),
      ],
    ),
  );
}

Future addSnackBar(BuildContext context, String txtTitle,double widht,double height, Widget widget) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
        backgroundColor: white,
        title: Text(
          txtTitle,
          style: TextStyle(fontSize: 25),
        ),
        content: Container(width: widht, height: height, child: widget)),
  );
}

BoxDecoration addBoxDecoration(Color colorFont){
  return BoxDecoration(
      color: colorFont,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
            color: kprimaryB.withOpacity(0.3), blurRadius: 5, spreadRadius: 1)
      ],
    );
        
}
