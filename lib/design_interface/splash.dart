import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:tests/design_interface/loginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isVisible = false;

  _SplashScreenState(){

    new Timer(const Duration(milliseconds: 6000), (){
      setState(() {
       Navigator.of(context).push(MaterialPageRoute(builder: (context){ return LoginPage();}));
    }); 
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: new LinearGradient(
        begin: FractionalOffset(0, 0),
        end: FractionalOffset(1.0, 0.0),
        stops: [0.0, 1.0],
        tileMode: TileMode.clamp,
        colors: [
          Color.fromARGB(255, 136, 24, 155),
          Color.fromARGB(255, 251, 221, 248)
        ],
      )),
        child: Center(
          child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 140,
                width: 140,
                child: Center(
                  child: ClipOval(
                    child: Icon(
                      Icons.android_outlined,
                      size: 120,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 2.0,
                          offset: Offset(5.0, 3.0),
                          spreadRadius: 2.0)
                    ]),
              ),
              SizedBox(height: 30,),
              Container(
              
            child:AnimatedTextKit(
                animatedTexts: [
                 
                  WavyAnimatedText('Welcom to our App',
                      textStyle: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          decoration: TextDecoration.none
                          )),
                ],
                isRepeatingAnimation: false,
                
                pause: Duration(minutes: 1),
          )
        ),
       
        
            ],
          ),
          
      ),
    );
    
  }
}
