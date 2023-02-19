import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class gesture extends StatefulWidget {
  const gesture({super.key});

  @override
  State<gesture> createState() => _gestureState();
}

class _gestureState extends State<gesture> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TextButton(
        onLongPress: () {
          //sets of code to execture after button long press
          print("Button is long pressed.");
        },
        onPressed: () {
          //sets of code to execute after button press
          print("Button is pressed");
        },
        child: Text("Press Button"),
      ),
    );
  }
}
