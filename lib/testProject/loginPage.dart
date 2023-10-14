import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tests/design_interface/Profile_interface.dart';
import 'package:tests/design_interface/forgetPassword/PhoneNumber.dart';
import 'package:tests/design_interface/register_interface.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tests/main.dart';
import 'package:tests/testProject/Data/Authentification.dart';



class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}): super(key:key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  TextEditingController userName=TextEditingController();
  TextEditingController password=TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late AuthService authService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authService=Get.find<AuthService>();

  }
  
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.topCenter,
              children:<Widget> [
                 Container(
                height:250,
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/backLogin.png"),fit: BoxFit.fitWidth)),
                  //let's create a common header widget
              ),
              Positioned(
                top: 50,
                child: Column(
                  children: [
                    Icon(Icons.person,size: 70,color: Color.fromARGB(146, 255, 255, 255),),
                    Text("Sign In",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                
                  ],
                )
              ),
             
              ],
            ),
            SafeArea(
              child: Form(
                key: _formKey,
                child: Container(
                  child: Column(
                    children: [
                      Text("HELLO",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30)),
                       SizedBox(height: 30.0),
                      SizedBox (
                        width: 300,
                        child: TextFormField(
                          controller: authService.authEmailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            ),
                            hintText: "User Name" 
                          ),
                          validator: (value) {
                            if(value!.isEmpty){
                              return "please enter your user name";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: authService.authMdpController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            ),
                            hintText: "Password" 
                          ),
                          obscureText: true,
                          validator: (value) {
                            if(value!.isEmpty){
                              return "please enter your password";
                            }
                            return null;
                          },
                        ),
                      ),
                       SizedBox(height: 10.0),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 50, 0),
                        alignment: Alignment.topRight,
                        child:GestureDetector(
                            onTap: () {
                            Get.to(()=>PhoneNumber());
                            },
                            child:  Text("Forget your password ?",textAlign: TextAlign.right),
                           ),
                    
                        ),
                        SizedBox(height: 20.0), 
                         ElevatedButton(
                          onPressed: (() {
                           login();
                          }),
                          child: Text("Sign IN",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white)),
                          
                          style:ButtonStyle(
                           shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                   ),
                                ),
                           backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 172, 89, 187)),
                           padding:MaterialStateProperty.all(EdgeInsets.fromLTRB(40, 10, 40, 10))   
                          ),
                         ),
                         SizedBox(height: 10.0),
                      Container(
                       
                        alignment: Alignment.center,
                        child:Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Don\'t have any account ?",
                              ),
                              TextSpan(
                                        text: 'Create',
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                                          },
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                            ]
                          )
                        )
                    
                        ),
                    ],
                  )
                ),
              ),
            )
           
          ],
        ),
      ),
    );

  }
  
  void login() {
    if(_formKey.currentState!.validate())
      authService.signIn(context);
  }
}
 