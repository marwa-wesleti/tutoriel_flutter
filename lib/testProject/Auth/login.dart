import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:tests/Constants/constants.dart';
import 'package:tests/testProject/Data/Authentification.dart';
import 'package:tests/testProject/Auth/Signup.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}


class _loginState extends State<login> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AuthService authService;
  var hidePassword = true.obs;


  @override
  void initState() {
    super.initState();
    CheckUserConnection();
    authService = Get.find<AuthService>();
    authService.authEmailController.text = "";
    authService.authMdpController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
            onRefresh: () async {
              await CheckUserConnection(); // Mettre à jour les données depuis Firebase
            },
      child: Obx(() => SingleChildScrollView(
          child: Container(
            width: Get.width,
            height: Get.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/backLogin.png"),
                    fit: BoxFit.fill)),
            child: SingleChildScrollView(
              child: Column(
                      children: [
                      Padding(
                        padding: EdgeInsets.only(top: 200),
                        child: addText("Se connecter", white, true, 40, false, ""),
                      ),
                      SizedBox(
                        height: 150,
                      ),
                      Visibility(
                        visible: authService.enableErreur.value,
                        child: Column(children: [addText(authService.erreur.value,red, true, 16, false, "schyler"),SizedBox(height: 10,)],)),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              addTextFieldWithIcon(
                                  colorFontTextField,
                                  Colors.black54,
                                  Icons.person_outlined,
                                  TextInputType.emailAddress,
                                  Get.width / 1.4,
                                  "Identifinant",
                                  authService.authEmailController),
                              SizedBox(
                                height: 40,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                padding: EdgeInsets.only(left: 15),
                                height: 65,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(99, 209, 208, 208),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.lock,
                                      size: 27,
                                      color: Colors.black54,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      width: Get.width / 1.4,
                                      child: TextFormField(
                                        controller: authService.authMdpController,
                                        obscureText: hidePassword.value,
                                        style: TextStyle(
                                            fontSize: 16.0, color: Colors.black),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Mot de passe",
                                          suffixIcon: IconButton(
                                            icon: hidePassword.value
                                                ? Icon(
                                                    Icons.visibility_off,
                                                    color: Colors.black54,
                                                  )
                                                : Icon(
                                                    Icons.visibility,
                                                    color: Colors.black54,
                                                  ),
                                            onPressed: () {
                                              
                                                hidePassword.value = !hidePassword.value;
                                              
                                            },
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Champ obligatoire";
                                          }
                                          if (value.length < 6) {
                                            return "Mot de passe supérieur à 6 caractères";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                margin: EdgeInsets.only(right: 50),
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () {
                                    //  Get.to(() => PhoneNumber());
                                  },
                                  child: Text("Mot de passe oublié?",
                                      textAlign: TextAlign.right),
                                ),
                              ),
                              SizedBox(height: 40.0),
                              ElevatedButton(
                                onPressed: (() {
                                  signIn();
                                }),
                                child: Text("Connexion",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white)),
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50.0),
                                      ),
                                    ),
                                    backgroundColor: MaterialStateProperty.all(kprimaryB),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.fromLTRB(40, 10, 40, 10))),
                              ),
                              SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Vous n'avez pas de compte ? "),
                                  GestureDetector(
                                      onTap: () {
                                        Get.to(() => Signup());
                                      },
                                      child: addText("Créer", kprimaryB, true, 16,
                                          TextDecoration.none, "")),
                                ],
                              ),
                              SizedBox(height: 20,)
                            ],
                          )),
                    ]),
            ),
                ),
              ),
      )),
      
      
    );
  }

  void signIn() async {
    if (_formKey.currentState!.validate()) {
      await authService.signIn(context);
    }
  }


 Future CheckUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      print(result);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print("connexion exist");
      }
    } on SocketException catch (_) {
      addSnackBar(
          context,
          "Aucune connexion Internet",
          100,50,
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage("assets/icons/sad.png"),width: 50,height: 50,),
                  SizedBox(width: 10,),
                  Image(image: AssetImage("assets/icons/sad.png"),width: 50,height: 50,),
                   SizedBox(width: 10,),
                  Image(image: AssetImage("assets/icons/sad.png"),width: 50,height: 50,),

                ],
              ),
             
            ],
          ));
    }
  }
}
