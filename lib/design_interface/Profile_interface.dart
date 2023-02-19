import 'package:tests/design_interface/loginPage.dart';
import 'package:tests/simple_test/listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Profile extends StatefulWidget {
  final String userName;
  final String password;
  final String? email;
  final String? phone;
  

  const Profile({super.key, required this.userName, required this.password, this.email,  this.phone});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.purple,
        title: Text(
          "Profile Page",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: Colors.white,
              )),
        ],

        flexibleSpace: Container(
          width: 400,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/backLogin.png"),
                  fit: BoxFit.fitWidth)),
        ),
      ),
      drawer: Container(
        width: 350,
        decoration: BoxDecoration(
           color: Colors.purple
        ),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                      SizedBox(height: 40,),
                      CircleAvatar(backgroundImage:AssetImage("assets/images/food.png"),radius: 60,),
                      SizedBox(height: 10,),
                      Text(widget.userName,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),)

                ],
              )
              ),
             Expanded(
              flex: 2,
               child: Column(
                children:<Widget> [
                   ...ListTile.divideTiles(
                              color: Colors.white,
                              tiles: [
                                ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 0),
                                  leading: Icon(Icons.person,color: Colors.white,),
                                  title: Text("Profile",style: TextStyle(color: Colors.white),),
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) =>Profile(userName: widget.userName, password: widget.password)));
                                  },
                                  
                                ),
                                ListTile(
                                  leading: Icon(Icons.settings,color: Colors.white,),
                                  title: Text("Settings",style: TextStyle(color: Colors.white)),
                                  
                                ),
                                ListTile(
                                  leading: Icon(Icons.logout_rounded,color: Colors.white),
                                  title: Text("logout",style: TextStyle(color: Colors.white)),
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>LoginPage()));
                                  },
                                  
                                ),
                               
                              ],
                            ),

                ],
               )
             ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 100,
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
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
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
                    margin: EdgeInsets.fromLTRB(70, 100, 0, 0),
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
            SizedBox(
              height: 10,
            ),
            Text(
              "${widget.userName}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
           
            Container(
              padding: EdgeInsets.all(10),
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                  alignment: Alignment.topLeft,
                  child: ListTile(
                    title:Text("User Information",
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  leading:GestureDetector(
                    child:Icon(Icons.edit,color: Colors.black,) ,
                    onTap: () {
                      debugPrint("Edit clicked");
                    },
                    )
                  )
                ),
                Card(
                  child: Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.all(15),
                    decoration:
                        BoxDecoration(color: Color.fromARGB(1, 255, 253, 253)),
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            ...ListTile.divideTiles(
                              color: Colors.grey,
                              tiles: [
                                ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 0),
                                  leading: Icon(Icons.my_location),
                                  title: Text("Location"),
                                  subtitle: Text("TUNISIA"),
                                ),
                                ListTile(
                                  leading: Icon(Icons.email),
                                  title: Text("Email"),
                                  subtitle: Text("${widget.email}"),
                                ),
                                ListTile(
                                  leading: Icon(Icons.phone),
                                  title: Text("Phone"),
                                  subtitle: Text("${widget.phone}"),
                                ),
                                ListTile(
                                  leading: Icon(Icons.password),
                                  title: Text("Password"),
                                  subtitle: Text("${widget.password}"),
                                ),
                                ListTile(
                                  leading: Icon(Icons.person),
                                  title: Text("About Me"),
                                  subtitle: Text(
                                      "This is a about me link and you can know about me in this section."),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
