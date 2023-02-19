

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ExempleStack extends StatefulWidget {
  const ExempleStack({super.key});

  @override
  State<ExempleStack> createState() => _stackState();
}

class _stackState extends State<ExempleStack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/food.png"))),
              ),
            ),
            Expanded(
                flex: 3,
                child: Container( 
                  decoration: BoxDecoration(color: Color.fromARGB(255, 239, 220, 193)),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "name",
                          ),
                        ),
                      ),
                      Container(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "email",
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        )
      ],
    ));
  }
}
