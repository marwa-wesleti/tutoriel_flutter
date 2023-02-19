
import 'package:tests/design_interface/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ForgetPass extends StatefulWidget {
  const ForgetPass({super.key});

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();

  verificationPass() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>LoginPage() ),
      );
  
}

    }
  

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
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/backLogin.png"),
                        fit: BoxFit.fill),
                  ),
                ),
                Center(
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 4,
                        )),
                    margin: EdgeInsets.fromLTRB(0, 70, 0, 0),
                    alignment: Alignment.center,
                    child: ClipOval(
                      child: Icon(
                        Icons.password,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              child: SafeArea(
                child: Container(
                  margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
                  child: Column(
                    children: [
                      Container(
                          alignment: Alignment.topLeft,
                          child: Text("Forgot\nPassword ?",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35))),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Enter the email address associated with your account.",
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "We will email you a verification code to check your authenticity",
                        style: TextStyle(color: Colors.black54),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: SizedBox(
                                  height: 70,
                                  width: 300,
                                  child: TextFormField(
                                    controller: email,
                                    decoration: InputDecoration(
                                      hintText: "Email adresse",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
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
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.fromLTRB(0, 0, 70, 0),
                                child: SizedBox(
                                  width: 150,
                                  height: 50,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        verificationPass();
                                      },
                                      child: Text(
                                        "SEND",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color.fromARGB(
                                                      255, 172, 89, 187)),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              50)))))),
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
