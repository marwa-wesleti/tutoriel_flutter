import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Drawer_date_alert extends StatefulWidget {
  const Drawer_date_alert({super.key});

  @override
  State<Drawer_date_alert> createState() => _Drawer_date_alertState();
}

class _Drawer_date_alertState extends State<Drawer_date_alert> {
  final GlobalKey<ScaffoldState> _sb=new GlobalKey<ScaffoldState>();

 var date="";

   supp(){
    showDialog(
      context: context,
        builder: (BuildContext context) => AlertDialog(
          backgroundColor: Color.fromARGB(255, 187, 214, 227),
          title: const Text('ATTENTION!!!'),
          content: const Text('Etes-vous sur de le supprimer?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => setState(() {
                Navigator.pop(context, date);
              }) ,
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => setState(() {
                Navigator.pop(context, date="");
              }) ,
              child: const Text('OK'),
            ),
          ],
        ),
    );
   }

   Future selectDate() async{
      DateTime? time=await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
         firstDate: DateTime(2020),
          lastDate: DateTime(2030)
          );
          if(time!=null) setState(() {
             date=time.day.toString()+"/"+time.month.toString()+"/"+time.year.toString();
          });
          
   }



  
  

  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      key: _sb,
        appBar: AppBar( 
          title: Text("Second Page"),
          
        ),
        drawer:
        Container(
          color: Color.fromARGB(255, 223, 91, 9),
          width: 350,
          child: Column(
            children:<Widget> [
              Padding(padding:  EdgeInsets.fromLTRB(50, 50, 0, 0)),
                //margin: EdgeInsets.fromLTRB(50, 50, 50, 0),
                
             CircleAvatar(backgroundImage: NetworkImage("https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fA%3D%3D&w=1000&q=80"),radius: 60,),
              
              Text("Marwa Wesleti",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              Text("marwa.wesleti007@gmail.com",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              Padding(padding:  EdgeInsets.fromLTRB(0, 30, 0, 0)),
                 Row(
                children: [
                  Icon(Icons.person,color: Colors.white,size: 20,),
                  Expanded(
                    child: ListTile(
                title: Text("Profile",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                onTap: () {
                  // traitement 
                },
              ) 
                  ),
                  ],
                ),
              
              Divider(color: Colors.white,),
              Row(
                children: [
                  Icon(Icons.privacy_tip,color: Colors.white,size: 20,),
                  Expanded(
                    child: ListTile(
                title: Text("Privacy Policy",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                onTap: () {
                  // traitement 
                },
              ) 
                  ),
                  ],
                ),
              
              Divider(color: Colors.white,),
               Row(
                children: [
                  Icon(Icons.settings,color: Colors.white,size: 20,),
                  Expanded(
                    child: ListTile(
                title: Text("Sittings",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                onTap: () {
                  // traitement 
                },
              ) 
                  ),
                  ],
                ),
             
              Divider(color: Colors.white,),
               Row(
                children: [
                  Icon(Icons.logout,color: Colors.white,size: 20,),
                  Expanded(
                    child: ListTile(
                title: Text("Sign Out",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                onTap: () {
                  // traitement 
                },
              ) 
                  ),
                  ],
                ),
              
              Divider(color: Colors.white,),
              
                
          
              
            ],
          ),
        ),
        //footerButton
         persistentFooterButtons:<Widget> [
          Icon(Icons.delete),
          Icon(Icons.shop), 
          Icon(Icons.money),

         ],

        
        body: Center( 
           child:Column(
            children:<Widget> [
               ElevatedButton(
             child: Text("Go Back"), //go back button
             onPressed: (){
                Navigator.pop(context);
             }
           ),
          
              ElevatedButton(
            onPressed:(() {
              setState(() {
                selectDate();
              });
            }
            ),
             child: Text("selectionner date")
             ),
             Text(date),
              ElevatedButton(
            onPressed:(() {
              setState(() {
                supp();
              });
            }
            ),
             child: Text("Supprimer date")
             ),
            
            ],

           )
        ),
     );
  }
}