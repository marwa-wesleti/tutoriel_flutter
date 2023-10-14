import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:tests/design_interface/Profile_interface.dart';
import 'package:tests/simple_test/TabBar.dart';
import 'package:tests/simple_test/TestImageAvatar.dart';
import 'package:tests/simple_test/emplois/homeWork_screen.dart';
import 'package:tests/simple_test/emplois/tableMulti.dart';
import 'package:tests/simple_test/gest.dart';
import 'package:tests/simple_test/listDeroulante.dart';
import 'package:tests/simple_test/listViwForm.dart';
import 'package:tests/simple_test/listview.dart';
import 'package:tests/simple_test/productBox.dart';
import 'package:tests/design_interface/splash.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tests/simple_test/testVocal.dart';
import 'package:tests/testProject/Auth/login.dart';
import 'firebase_options.dart';
import 'simple_test/detectorImage.dart';
import 'simple_test/drawerDateAlert.dart';
import 'simple_test/gridview.dart';
import 'package:tests/testProject/loginPage.dart';
import 'Notification/showNotification.dart';
import 'Constants/Init.dart' as depandancie;

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,);
 await depandancie.init();

  runApp(MyApp());
} 

  

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      routes: {
        "MyHomePage": (context) => MyHomePage(),
        "SecondScreen": (context) => Drawer_date_alert(),
        "ExempleStack": (context) => ExempleStack(),
        "listview": (context) => listview(),
        "gridview": (context) => gridview(),
        "splash": (context) => SplashScreen(),
        "LoginPage": (context) => login(),
        "Profile": (context) => Profile(),
       
      },
     // initialRoute: "MyHomePage",
      home: login(),
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
      body: SingleChildScrollView(
        child: Center(
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
                  child: Text("test database"), //click me button
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => SplashScreen()));
                  }),
             /*  ElevatedButton(
                  child: Text("test dataTable"), //click me button
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MyDataTable()));
                  }), */
                   ElevatedButton(
                  child: Text("test calendarEvent"), //click me button
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => Emplois()));
                  }),
                  ElevatedButton(
                  child: Text("test listViewAvecForm"), //click me button
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => listViewForm()));
                  }),
                   ElevatedButton(
                  child: Text("test tabBar"), //click me button
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MyTabBar()));
                  }),
                  ElevatedButton(
                  child: Text("test listDeroulante"), //click me button
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => ExamplePage()));
                  }),
                   ElevatedButton(
                  child: Text("test notification"), //click me button
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => showNotification()));
                  }),
                   ElevatedButton(
                  child: Text("test table multidimentionnel"), //click me button
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => table()));
                  }),
                    ElevatedButton(
                  child: Text("test Ajouter image avatar"), //click me button
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => AvatarPage()));
                  }), 
                   ElevatedButton(
                  child: Text("test orthopro "), //click me button
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => login()));
                  }), 
                   ElevatedButton(
                  child: Text("test reconaizer image "), //click me button
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MyWidget()));
                  }), 

                   ElevatedButton(
                  child: Text("test reconaizer voice "), //click me button
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => testVoice()));
                  }), 
            ],
          ),
        ),
      )
    );
  }
}
