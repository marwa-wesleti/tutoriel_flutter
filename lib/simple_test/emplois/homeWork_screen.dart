import 'package:tests/Constants/constants.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:tests/Constants/constants.dart';
import 'package:tests/simple_test/emplois/data_homeWork.dart';

class Emplois extends StatefulWidget {
  const Emplois({Key? key}) : super(key: key);
  static String routeName = 'Emplois';
  @override
  State<Emplois> createState() => _EmploisState();
}

class _EmploisState extends State<Emplois> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        // AppBar

        appBar: AppBar(
          title: const Text(
            " Travail à faire",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          centerTitle: true,
          actions: const [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Icon(Icons.notifications),
            )
          ],
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: kPrimaryColor,
            letterSpacing: 1.0,
          ),
          backgroundColor: kOtherColor,
          iconTheme: const IconThemeData(
            color: kPrimaryColor,
            size: 30,
          ),
          toolbarHeight: 50,
        ),
        body: Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/backstudy.png"),
              fit: BoxFit.fill,
            ),
            color: white,
          ),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  height: size.height / 2,
                  width: size.width / 2,
                  child: Image(
                    image: AssetImage("assets/images/timetable.png"),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: ListView.builder(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    itemCount: emplois.length,
                    itemBuilder: (context, int index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: white,
                              ),
                              child: Container(
                                width: size.width,
                                height: 200,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(255, 227, 227, 227),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${emplois[index].jour}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children:const [
                                            Text("8 _ 9",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 198, 36, 24))),
                                            
                                            Text("Math",
                                                style: TextStyle(fontSize: 16)),
                                            
                                            Text("5",
                                                style: TextStyle(fontSize: 16)),
                                           
                                            Divider(
                                              color: Color.fromARGB(
                                                        255, 198, 36, 24), // sets the color of the divider
                                              thickness:
                                                  2, // sets the thickness of the divider in logical pixels
                                              height: 16,
                                            ),
                                            Text("8 _ 9",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 198, 36, 24))),
                                           
                                            Text("Math",
                                                style: TextStyle(fontSize: 16)),
                                            
                                            Text("5",
                                                style: TextStyle(fontSize: 16)),
                                          ],
                                        )),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children:const [
                                            Text("8 _ 9",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 198, 36, 24))),
                                            
                                            Text("Math",
                                                style: TextStyle(fontSize: 16)),
                                            
                                            Text("5",
                                                style: TextStyle(fontSize: 16)),
                                           
                                            Divider(
                                              color: Color.fromARGB(
                                                        255, 198, 36, 24), // sets the color of the divider
                                              thickness:
                                                  2, // sets the thickness of the divider in logical pixels
                                              height: 16,
                                            ),
                                            Text("8 _ 9",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 198, 36, 24))),
                                           
                                            Text("Math",
                                                style: TextStyle(fontSize: 16)),
                                            
                                            Text("5",
                                                style: TextStyle(fontSize: 16)),
                                          ],
                                        )),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children:const [
                                            Text("8 _ 9",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 198, 36, 24))),
                                            
                                            Text("Math",
                                                style: TextStyle(fontSize: 16)),
                                            
                                            Text("5",
                                                style: TextStyle(fontSize: 16)),
                                           
                                            Divider(
                                              color: Color.fromARGB(
                                                        255, 198, 36, 24), // sets the color of the divider
                                              thickness:
                                                  2, // sets the thickness of the divider in logical pixels
                                              height: 16,
                                            ),
                                            Text("8 _ 9",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 198, 36, 24))),
                                           
                                            Text("Math",
                                                style: TextStyle(fontSize: 16)),
                                            
                                            Text("5",
                                                style: TextStyle(fontSize: 16)),
                                          ],
                                        )),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children:const [
                                            Text("8 _ 9",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 198, 36, 24))),
                                            
                                            Text("Math",
                                                style: TextStyle(fontSize: 16)),
                                            
                                            Text("5",
                                                style: TextStyle(fontSize: 16)),
                                           
                                            Divider(
                                              color: Color.fromARGB(
                                                        255, 198, 36, 24), // sets the color of the divider
                                              thickness:
                                                  2, // sets the thickness of the divider in logical pixels
                                              height: 16,
                                            ),
                                            Text("8 _ 9",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 198, 36, 24))),
                                           
                                            Text("Math",
                                                style: TextStyle(fontSize: 16)),
                                            
                                            Text("5",
                                                style: TextStyle(fontSize: 16)),
                                          ],
                                        ))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}

