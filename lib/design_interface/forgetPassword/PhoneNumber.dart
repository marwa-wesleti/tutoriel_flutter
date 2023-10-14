import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tests/Constants/constants.dart';
import 'package:tests/design_interface/forgetPassword/PhoneCode.dart';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({super.key});

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("widh ${Get.width} , height ${Get.height}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          height: Get.height,
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 450,),
              addText(
                " Ne vous inquiétez pas ! cela arrive. Veuillez \n entrer votre numéro de téléphone.",
                Color.fromARGB(190, 0, 0, 0),
                true,
                20,
                false,
                "Schyler"),
            SizedBox(
              height: 30,
            ),    
            Form(
                key: _formkey,
                child: Column(
                  children: [
                    addTextFieldWithIcon(
                        colorFontTextField,
                        Colors.black45,
                        Icons.phone_outlined,
                        TextInputType.emailAddress,
                        Get.width / 2,
                        "Numéro du téléphone",
                        phoneController),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        onPressed: (() {
                        }),
                        child: addText("Suivant", white, true, 25, false, "Schyler"),
                        style: addButtonStyle(50.0, kprimaryB)),
                  ],
                ))
            ],
          ),
        ),
      ),

    );
  }

  
  
}












/* 
SingleChildScrollView(
          child: Column(
        children: [
          Stack(
            children: [
              Container(
                  width: Get.width,
                  height: Get.height / 2.5,
                  decoration: BoxDecoration(
                      color: kprimaryB,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(80),
                          bottomRight: Radius.circular(80)))),
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 70),
                child: Image(
                    image:
                        AssetImage("assets/images/phoneNumberPage/ballG.PNG")),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100, top: 150),
                child: Image(
                    image:
                        AssetImage("assets/images/phoneNumberPage/ballB.PNG")),
              ),
              Container(
                alignment: Alignment.topRight,
                padding: const EdgeInsets.only(right: 30, top: 100),
                child: Image(
                    image:
                        AssetImage("assets/images/phoneNumberPage/ballO.PNG")),
              ),
              Container(
                alignment: Alignment.topRight,
                padding: const EdgeInsets.only(right: 20, top: 180),
                child: Image(
                    image: AssetImage(
                        "assets/images/phoneNumberPage/message.PNG")),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 430),
                child: Image(
                    image:
                        AssetImage("assets/images/phoneNumberPage/khyell.PNG")),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 250),
                child: Image(
                  image:
                      AssetImage("assets/images/phoneNumberPage/penguin.PNG"),
                  width: 225,
                  height: 230,
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right:20,top: 360),
                child: Image(
                    image:
                        AssetImage("assets/images/phoneNumberPage/BallV.PNG")),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          addText(
              " Ne vous inquiétez pas ! cela arrive. Veuillez \n entrer votre numéro de téléphone.",
              Color.fromARGB(190, 0, 0, 0),
              true,
              20,
              false,
              "Schyler"),
          SizedBox(
            height: 30,
          ),    
          Form(
              key: _formkey,
              child: Column(
                children: [
                  addTextFieldWithIcon(
                      colorFontTextField,
                      Colors.black45,
                      Icons.phone_outlined,
                      TextInputType.phone,
                      Get.width / 2,
                      "Numéro du Téléphone",
                      phoneController),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: (() {
                        Get.to(() => PhoneCode());
                      }),
                      child: addText("Next", white, true, 25, false, "Schyler"),
                      style: addButtonStyle(50.0, kprimaryB)),
                ],
              ))
        ],
      )),
 */