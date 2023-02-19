import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tests/design_interface/Profile_interface.dart';
import 'package:tests/design_interface/forget_password.dart';
import 'package:tests/design_interface/register_interface.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tests/main.dart';



class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}): super(key:key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  TextEditingController userName=TextEditingController();
  TextEditingController password=TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String url="http://172.16.122.150/testFlutter/login.php";
  Future login() async {
    if(_formKey.currentState!.validate()){
      final response=await http.post(Uri.parse(url),body: {
        "userName": userName.text,
        "password": password.text
      });
      
      var result=json.decode(response.body);
      print(result);
     if(result.length==0){
        Fluttertoast.showToast(
        msg: "user inexistant",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Color.fromARGB(255, 95, 92, 92),
        textColor: Colors.white);
     }
     else{
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) =>Profile(
        userName:"welcom "+ result[0]["firstName"],
         password:result[0]["pass"],
         email: result[0]["email"],
         phone: result[0]["mobile"],
         ) ));
     }
        
     
        
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
                          controller: userName,
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
                          controller: password,
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
                              Navigator.of(context).push(MaterialPageRoute(
                                builder:(BuildContext context)=>ForgetPass())
                                );
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
}
 class user {
   int? id;
   String? firstName;
   String? lasttName;
   String? email;
   String? mobile;
   String? password;
   
  user({this.id,this.firstName,this.lasttName,this.email,this.mobile,this.password});


}