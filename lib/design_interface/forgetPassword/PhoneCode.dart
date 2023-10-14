import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:tests/Constants/constants.dart';
import 'package:tests/design_interface/forgetPassword/NewPassword.dart';

class PhoneCode extends StatefulWidget {
  final String number;
  const PhoneCode({super.key,required this.number});

  @override
  State<PhoneCode> createState() => _PhoneCodeState();
}

class _PhoneCodeState extends State<PhoneCode> {
  String code="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verifyCode();
  }
  CollectionReference userCollection=FirebaseFirestore.instance.collection("users");
  FirebaseAuth auth=FirebaseAuth.instance;
  final TextEditingController _pinPutController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        body: SingleChildScrollView(
          child:Container(
          width: Get.width,
          height: Get.height,
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 450,),
               addText(" Un code à 6 chiffres a été envoyé à \n +216",
                Color.fromARGB(190, 0, 0, 0), true, 23, false, "Schyler"),
          SizedBox(
            height: 30,
          ),
          Pinput(
            length: 6,
            defaultPinTheme: PinTheme(
              width: 56,
              height: 56,
              textStyle: TextStyle(
                  fontSize: 20, color: kprimaryB, fontWeight: FontWeight.bold),
              decoration: BoxDecoration(
                color: Color.fromRGBO(234, 239, 243, 1),
                border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            controller: _pinPutController,
            showCursor: true,
            onCompleted: (pin) => print(pin),
          ),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () {
              confirmCode();
            },
            child: addText(
                "vérifier le code", white, true, 25, false, ""),
            style: addButtonStyle(50.0, kprimaryB),
          )
            ],
          ) ,
          
          )
        )
          );
  }
  void verifyCode()async{
       await auth.verifyPhoneNumber(
  phoneNumber: '+216'+widget.number,
  verificationCompleted: (PhoneAuthCredential credential) {},
  verificationFailed: (FirebaseAuthException e) {},
  codeSent: (String verificationId, int? resendToken) async{
  
   
  },
  timeout: const Duration(seconds: 60),
  codeAutoRetrievalTimeout: (String verificationId) {},
);
   
   
}
 void confirmCode()async{
    
   
    print(_pinPutController.text); 
    PhoneAuthCredential credential=PhoneAuthProvider.credential(verificationId: code, smsCode: _pinPutController.text);
    try {
     UserCredential authResult = await auth.signInWithCredential(credential);
    User user = authResult.user!;
    if(user!=null){
        Get.to(()=>NewPassword(),arguments: user.uid);
    } 
    } catch (e) {
      addToast("code invalid");
    }
    
    
  }





/* 
 Column(children: [
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
             
              Positioned(
                left: Get.width * 0.1,
                top: Get.height * 0.07,
                child: Image.asset("assets/images/phoneNumberPage/ballG.PNG"),
              ),
               Positioned(
                left: Get.width * 0.25,
                top: Get.height * 0.15,
                child: Image.asset("assets/images/phoneNumberPage/ballB.PNG"),
              ),
             Positioned(
                right: Get.width * 0.1,
                top: Get.height * 0.1,
                child: Image.asset("assets/images/phoneNumberPage/ballO.PNG"),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 150),
                child: Image(
                  image: AssetImage("assets/images/phoneNumberPage/phone.PNG"),
                  width: Get.width / 2,
                  height: Get.height / 3,
                ),
              ),
               Positioned(
                right: Get.width * 0.04,
                top: Get.height * 0.4,
                child: Image.asset("assets/images/phoneNumberPage/BallV.PNG"),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            alignment: Alignment.topLeft,
            child: addText("Un code à 4 chiffres a été envoyé à \n +216",
                Color.fromARGB(190, 0, 0, 0), true, 20, false, "Schyler"),
          ),
          SizedBox(
            height: 30,
          ),
          Pinput(
            length: 6,
            defaultPinTheme: PinTheme(
              width: 56,
              height: 56,
              textStyle: TextStyle(
                  fontSize: 20, color: kprimaryB, fontWeight: FontWeight.w600),
              decoration: BoxDecoration(
                color: Color.fromRGBO(234, 239, 243, 1),
                border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            controller: _pinPutController,
            showCursor: true,
            onCompleted: (pin) => print(pin),
          ),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(()=>NewPassword());
            },
            child: addText(
                "vérifier le code", white, true, 25, false, ""),
            style: addButtonStyle(50.0, kprimaryB),
          )
        ])
 */
}