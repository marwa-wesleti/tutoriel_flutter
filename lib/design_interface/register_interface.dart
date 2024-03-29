import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tests/Constants/constants.dart';
import 'package:tests/design_interface/Profile_interface.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tests/testProject/loginPage.dart';
import 'package:tests/design_interface/verifyPhone.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController firstName = TextEditingController();
  TextEditingController LastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController Number = TextEditingController();
  TextEditingController pass = TextEditingController();

  bool? check = false;
  final _formKey = GlobalKey<FormState>();
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/backLogin.png"),
                          fit: BoxFit.fill)),
                ),
                Center(
                  child: Container(
                    height: 100,
                    width: 100,
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
                    margin: EdgeInsets.fromLTRB(0, 70, 0, 0),
                    alignment: Alignment.center,
                    child: ClipOval(
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: Color.fromARGB(120, 158, 158, 158),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 101, 99, 99),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 2.0,
                              offset: Offset(5.0, 3.0),
                              spreadRadius: 2.0)
                        ]),
                    margin: EdgeInsets.fromLTRB(70, 150, 0, 0),
                    alignment: Alignment.center,
                    child: ClipOval(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SafeArea(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 70,
                      width: 300,
                      child: TextFormField(
                        controller: firstName,
                        decoration: InputDecoration(
                          hintText: "First Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 70,
                      width: 300,
                      child: TextFormField(
                        controller: LastName,
                        decoration: InputDecoration(
                            hintText: "Last Name",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 70,
                      width: 300,
                      child: TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                          hintText: "Email adresse",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your email address";
                          }
                          if (!(value.isEmpty) &&
                              !RegExp(r"@").hasMatch(value)) {
                            return "Enter a valid email address";
                          }

                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 70,
                      width: 300,
                      child: TextFormField(
                        controller: Number,
                        decoration: InputDecoration(
                            hintText: "Mobile Number",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            )),
                        keyboardType: TextInputType.phone,
                        validator: (val) {
                          if (!(val!.isEmpty) &&
                              !RegExp(r"^(\d+)*$").hasMatch(val)) {
                            return "Enter a valid phone number";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 70,
                      width: 300,
                      child: TextFormField(
                        controller: pass,
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                        obscureText: true,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter your password";
                          }
                          if (val.length < 6) {
                            return "Please enter a password > 6 carracter";
                          }
                          return null;
                        },
                      ),
                    ),
                    FormField<bool>(
                      builder: (state) {
                        return Column(
                          children: <Widget>[
                            CheckboxListTile(
                              value: check,
                              onChanged: (value) {
                                setState(() {
                                  check = value!;
                                  state.didChange(value);
                                });
                              },
                              title: Text(
                                "I accept all terms and conditions.",
                                style: TextStyle(color: Colors.grey),
                              ),
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                state.errorText ?? '',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Theme.of(context).errorColor,
                                  fontSize: 12,
                                ),
                              ),
                            )
                          ],
                        );
                      },
                      validator: (value) {
                        if (!check!) {
                          return 'You need to accept terms and conditions';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                          onPressed: () {
                            register();
                          },
                          child: Text(
                            "REGISTER",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 172, 89, 187)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50)))))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Or create account using social media",
                        style: TextStyle(color: Colors.grey)),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            child: GestureDetector(
                          child: Image(
                              image: AssetImage("assets/images/google.png")),
                        )),
                        Container(
                            margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Image(
                                image:
                                    AssetImage("assets/images/facebook.png"))),
                        Container(
                            margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Image(
                                image:
                                    AssetImage("assets/images/twitter.png"))),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void register() async {
    try {
      UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: email.text,
        password: pass.text,
      );
       await auth.setLanguageCode('fr');
      await userCredential.user!.sendEmailVerification();// yaab3eth lel user email de vérification
      addToast("Un e-mail de vérification a été envoyé à ${email.text}");

       Map<String, dynamic> userData ={
        'Nom complet': firstName.text,
        'Email': email.text,
        'Telephone': Number.text
      };

      
       // await _usersCollection.doc(userCredential.user!.uid).set(userData).then((value) => Get.to(()=>LoginPage()));
      

    }on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        addToast("email exist");
      }

    } catch (e) {
        
    }
  }
}
