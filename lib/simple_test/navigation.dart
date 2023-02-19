

import 'package:tests/simple_test/listview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class detailsplane extends StatelessWidget {
  final String image;
  final String place;
  final String time;

  const detailsplane({super.key,required this.image, required this.place, required this.time});



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [ 
         Image(image: AssetImage("$image"),height: 40,),
          Text("Place : $place",style: TextStyle(fontSize: 20,color: Colors.black),),
          Text("time : $time",style: TextStyle(fontSize: 20,color: Colors.black)),
          ElevatedButton(
            onPressed: (() {
              Navigator.of(context).pop(
                airPlan(place: "india", time: "10h")
                );
            }), 
            child: Text("send"))
        ],
      ),
    );
  }
}