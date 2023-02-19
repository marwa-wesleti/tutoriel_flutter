import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'navigation.dart';



class listview extends StatefulWidget {
 
  const listview({super.key});

  @override
  State<listview> createState() => _listviewState();
}

class _listviewState extends State<listview> {
  TextEditingController txtPlace = TextEditingController();
  TextEditingController txtTime = TextEditingController();

  List<airPlan> plan = [
    airPlan(place: "Tunis-->France", time: "15H-->17H"),
  ];

  list() {
    return ListView.builder(
        itemCount: plan.length,
        itemBuilder: (context, index) {
          return
              /**/
              Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                  child: Image(
                image: AssetImage("assets/images/plane.png"),
                height: 50,
                color: Colors.red,
              )),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(plan[index].place!,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      subtitle: Text(plan[index].time!,
                          style: TextStyle(
                              color: Color.fromARGB(255, 40, 129, 43),
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                        
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                  child:IconButton(icon: Icon(Icons.more_horiz_outlined),
                  iconSize: 30,
                  color: Colors.red,
                  onPressed: () {
                    setState(() {
                      navigation(context,index);
                        
                    });
                  },
                  ),
               
               
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(50),
              alignment: Alignment.center,
              child: Text(
                "tableau de bord air Tunis",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30),
              )),
          TextField(
            controller: txtPlace,
            decoration: InputDecoration(
                hintText: "enter place",
                icon: Icon(
                  Icons.place,
                  color: Colors.black,
                )),
          ),
          
          TextField(
            controller: txtTime,
            decoration: InputDecoration(
                hintText: "enter time",
                icon: Icon(
                  Icons.punch_clock,
                  color: Colors.black,
                )),
          ),
          ElevatedButton(
              onPressed: (() {
                setState(() {
                  plan.add(airPlan(place: txtPlace.text, time: txtTime.text));
                });
              }),
              child: Text("Add")),
          Container(
            height: 300,
            decoration:
            
                BoxDecoration(color: Color.fromARGB(255, 216, 237, 255)),
            child: list(),
          ),
        ],
      ),
    );
  }
  
  Future <void> navigation(BuildContext context, int index) async{
    var route= MaterialPageRoute(
                        builder: (BuildContext context) => detailsplane(
                         image: "assets/images/plane.png" ,
                          place: plan[index].place!,
                          time: plan[index].time!,
                        ));
    final result=  await Navigator.of(context).push(route);
          if (!mounted) return;
        if(result!=null){ plan.add(result);}
        
          setState(() { 
          });

  }
}

class airPlan {
  String? place;
  String? time;
  airPlan({ this.place,  this.time});
}
