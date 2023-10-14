import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tests/Constants/constants.dart';
import 'package:tests/testProject/Apprenant/NivPage.dart';
import 'package:tests/Constants/identifiant.dart';

class AppHome1 extends StatefulWidget {
  const AppHome1({super.key});

  @override
  State<AppHome1> createState() => _AppHome1State();
}

class _AppHome1State extends State<AppHome1> {
  final Identifiant identifiant=Get.find<Identifiant>();
  
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/backHome.PNG"),fit: BoxFit.fill),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
               ElevatedButton(
                  onPressed: () {
                      Get.to(()=>PageNiveau());
                  },
                  child: addText("Commencer", white, true, 25, false, "schyler"),
                  style: addButtonStyle(50, kprimaryB),
                ),
                SizedBox(height: 50,)
             
            ],
          ),
        ),
      ),
    );
  }
}