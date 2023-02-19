import 'package:tests/design_interface/Profile_interface.dart';
import 'package:tests/simple_test/gest.dart';
import 'package:tests/simple_test/listview.dart';
import 'package:tests/simple_test/productBox.dart';
import 'package:tests/design_interface/splash.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'simple_test/drawerDateAlert.dart';
import 'simple_test/gridview.dart';
import 'package:tests/design_interface/loginPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "MyHomePage": (context) => MyHomePage(),
        "SecondScreen": (context) => Drawer_date_alert(),
        "ExempleStack": (context) => ExempleStack(),
        "listview": (context) => listview(),
        "gridview": (context) => gridview(),
        "splash": (context) => SplashScreen(),
        "LoginPage": (context) => LoginPage(),
        "Profile": (context) => Profile(userName: "", password: "")
      },
      initialRoute: "MyHomePage",
      title: 'Hello World Demo Application',
      theme: ThemeData(),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<BottomNavigationBarItem> _item = [
    BottomNavigationBarItem(icon: Icon(Icons.person), label: "person"),
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
    BottomNavigationBarItem(icon: Icon(Icons.facebook), label: "facebook"),
  ];

  testToast() {
    Fluttertoast.showToast(
        msg: "test toast",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Color.fromARGB(255, 95, 92, 92),
        textColor: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple test"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _item,
      ),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
              child: Text("test Calendrier&alertDialog"), //click me button
              onPressed: () {
                Navigator.pushNamed(context, "SecondScreen");
              }),
          ElevatedButton(
              child: Text("go to listView&Navigation"), //click me button
              onPressed: () {
                Navigator.pushNamed(context, "listview");
              }),
          ElevatedButton(
              child: Text("go to gridView"), //click me button
              onPressed: () {
                Navigator.pushNamed(context, "gridview");
              }),
          ElevatedButton(
              child: Text("test gestures"), //click me button
              onPressed: () {
                var route = MaterialPageRoute(
                    builder: (BuildContext context) => gesture());
                Navigator.of(context).push(route);
              }),
          ElevatedButton(
              child: Text("test Toast"), //click me button
              onPressed: () {
                testToast();
              }),
          ElevatedButton(
              child: Text("test design"), //click me button
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => SplashScreen()));
              }),
          
        ],
      )),
    );
  }
}
