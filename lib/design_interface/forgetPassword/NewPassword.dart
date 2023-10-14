import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tests/Constants/constants.dart';
import 'package:tests/design_interface/Profile_interface.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
bool hidePassword = true;
  GlobalKey<FormState> _formKey=  GlobalKey<FormState>();
TextEditingController mdpController=TextEditingController();
TextEditingController confirmMdpController=TextEditingController();
FirebaseAuth auth=FirebaseAuth.instance;
CollectionReference userCollection=FirebaseFirestore.instance.collection("users");



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
              SizedBox(height: 400,), 
              addText("Réinitialiser le mot de passe?", black, true, 25, false, "Schyler"),
         SizedBox(height: 30,),

            Form(
              key: _formKey,
              child: Column(
                children: [
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
                              controller: mdpController,
                              obscureText: hidePassword,
                              style:
                                  TextStyle(fontSize: 16.0, color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Mot de passe",
                                suffixIcon: IconButton(
                                  icon: hidePassword
                                      ? Icon(
                                          Icons.visibility_off,
                                          color: Colors.black54,
                                        )
                                      : Icon(
                                          Icons.visibility,
                                          color: Colors.black54,
                                        ),
                                  onPressed: () {
                                    setState(() {
                                      hidePassword = !hidePassword;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Veuillez entrer votre mot de passe";
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
                    SizedBox(height: 30,),
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
                              controller: confirmMdpController,
                              obscureText: hidePassword,
                              style:
                                  TextStyle(fontSize: 16.0, color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Confirme mot de passe",
                                suffixIcon: IconButton(
                                  icon: hidePassword
                                      ? Icon(
                                          Icons.visibility_off,
                                          color: Colors.black54,
                                        )
                                      : Icon(
                                          Icons.visibility,
                                          color: Colors.black54,
                                        ),
                                  onPressed: () {
                                    setState(() {
                                      hidePassword = !hidePassword;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Veuillez entrer votre mot de passe";
                                }
                                if (!(value==mdpController.text)) {
                                  return "Mot de passe incorrect";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30,),
                    ElevatedButton(
                      onPressed: () {
                        updatePassword();
                      },
                       child:addText("Modifier", white, true, 25, false, ""),
                       style: addButtonStyle(50, kprimaryB),
                       
                       )
                ],
              ))
            ]
        )
        )
        )
    );
          
  }
  
  void updatePassword() async {
    if(_formKey.currentState!.validate()){
      try {
    User? user = auth.currentUser;
        print(user!.uid);

    if (user != null && user.uid==Get.arguments) {
      await user.updatePassword(confirmMdpController.text);
      await userCollection.doc(Get.arguments).update({'password': confirmMdpController.text});
      addToast("Mot de passe modifié avec succé");
      Get.to(()=>Profile());
    } else {
      print('Aucun utilisateur n\'est actuellement connecté.');
    }
  } catch (e) {
    print('Erreur lors de la mise à jour du mot de passe : $e');
  }
    }
  }
}








/* 
Column(
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
                          bottomRight: Radius.circular(80)
                          )
                          )
                          ),
               Positioned(
                left: Get.width * 0.5,
                top: Get.height * 0.15,
                child: Image.asset("assets/images/phoneNumberPage/interrogation.PNG"),
              ),           
                          
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
              
                Positioned(
                top: Get.height * 0.42,
                left: Get.width * 0.05,
                child: Image.asset("assets/images/phoneNumberPage/khyell.PNG"),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 120),
                child: Image(
                  image:
                      AssetImage("assets/images/phoneNumberPage/penguin.PNG"),
                  width: Get.width,
                  height: Get.height/2.3,
                ),
              ),
               
            ],
          ),
        addText("Réinitialiser le mot de passe?", black, true, 25, false, "Schyler"),
         SizedBox(height: 30,),

            Form(
              key: _formKey,
              child: Column(
                children: [
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
                              controller: mdpController,
                              obscureText: hidePassword,
                              style:
                                  TextStyle(fontSize: 16.0, color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Mot de passe",
                                suffixIcon: IconButton(
                                  icon: hidePassword
                                      ? Icon(
                                          Icons.visibility_off,
                                          color: Colors.black54,
                                        )
                                      : Icon(
                                          Icons.visibility,
                                          color: Colors.black54,
                                        ),
                                  onPressed: () {
                                    setState(() {
                                      hidePassword = !hidePassword;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Veuillez entrer votre mot de passe";
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
                    SizedBox(height: 30,),
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
                              controller: confirmMdpController,
                              obscureText: hidePassword,
                              style:
                                  TextStyle(fontSize: 16.0, color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Confirme mot de passe",
                                suffixIcon: IconButton(
                                  icon: hidePassword
                                      ? Icon(
                                          Icons.visibility_off,
                                          color: Colors.black54,
                                        )
                                      : Icon(
                                          Icons.visibility,
                                          color: Colors.black54,
                                        ),
                                  onPressed: () {
                                    setState(() {
                                      hidePassword = !hidePassword;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Veuillez entrer votre mot de passe";
                                }
                                if (!(value.length==mdpController.text)) {
                                  return "Mot de passe supérieur à 6 caractères";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30,),
                    ElevatedButton(
                      onPressed: () {
                        
                      },
                       child:addText("Modifier", white, true, 25, false, ""),
                       style: addButtonStyle(50, kprimaryB),
                       
                       )
                ],
              ))

            ]
            )
 */