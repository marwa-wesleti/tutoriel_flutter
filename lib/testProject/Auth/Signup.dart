import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tests/Constants/constants.dart';
import 'package:tests/testProject/Data/Authentification.dart';

enum Genre { masculin, feminin }

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var hidePassword = true.obs;
  late AuthService authService;
  var itemsDropDown = ['Enseignant', 'Apprenant'];

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var enableNiv = true.obs;

  @override
  void initState() {
    super.initState();
    authService = Get.find<AuthService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/backLogin.png"),
                fit: BoxFit.fill),
          ),
          child: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: EdgeInsets.only(top: 150),
                child: addText("Créer un compte", white, true, 40, false, ""),
              ),
              SizedBox(
                height: 150,
              ),
              Obx(() => Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        width: Get.width / 1.2,
                        child: DropdownButtonFormField<String>(
                          hint: Text(authService.dropDownTypeValue.value),
                          items: itemsDropDown.map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            authService.dropDownTypeValue.value = newValue!;
                            print(authService.dropDownTypeValue.value);
                            if (authService.dropDownTypeValue.value ==
                                "Apprenant")
                              enableNiv.value = true;
                            else
                              enableNiv.value = false;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      addTextFiel(
                          Color.fromARGB(99, 209, 208, 208),
                          TextInputType.text,
                          Get.width / 1.2,
                          "Nom Complet",
                          authService.nomController),
                      SizedBox(
                        height: 20,
                      ),
                      addTextFiel(
                          colorFontTextField,
                          TextInputType.number,
                          Get.width / 1.2,
                          "Téléphone",
                          authService.tlfController),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: addText("Genre", black, true, 16, false, "schyler")),
                            Expanded(
                              flex: 2,
                              child: RadioListTile(
                                title: addText("masculin", black, false, 16, false,
                                    "schyler"),
                                value: "masculin",
                                groupValue: authService.genre.value,
                                onChanged: (value) {
                                  authService.genre.value = value.toString();
                                  print(authService.genre.value);
                                },
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: RadioListTile(
                                title: addText(
                                    "féminin", black, false, 16, false, "schyler"),
                                value: "féminin",
                                groupValue: authService.genre.value,
                                onChanged: (value) {
                                  authService.genre.value = value.toString();
                                  print(authService.genre.value);

                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                          visible: enableNiv.value,
                          child: Column(
                            children: [
                              addTextFiel(
                                  colorFontTextField,
                                  TextInputType.text,
                                  Get.width / 1.2,
                                  "Niveau Actuel",
                                  authService.nivController),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          )),
                      addTextFieldWithIcon(
                          colorFontTextField,
                          Colors.black54,
                          Icons.person_outlined,
                          TextInputType.emailAddress,
                          Get.width / 1.4,
                          "Identifiant",
                          authService.emailController),
                      SizedBox(
                        height: 20,
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
                                controller: authService.mdpController,
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
                                            color: Colors.black,
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
                                    return "mot de passe supérieur à 6 caractères";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40.0),
                      ElevatedButton(
                        onPressed: (() {
                          create();
                        }),
                        child: Text("Inscription",
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
                            backgroundColor:
                                MaterialStateProperty.all(kprimaryB),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.fromLTRB(40, 10, 40, 10))),
                      ),
                      SizedBox(height: 40.0),
                    ],
                  ))),
            ]),
          )),
    ));
  }

  void create() async {
    if (_formKey.currentState!.validate()) {
      await authService.signUp(context);
      authService.emailController.text = "";
      authService.mdpController.text = "";
      authService.nomController.text = "";
      authService.tlfController.text = "";
      authService.nivController.text = "";
      authService.dropDownTypeValue.value = "Apprenant";
    }
  }
}
