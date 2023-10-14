import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tests/Notification/DetailsNotif.dart';
import 'package:tests/Notification/NotificationApi.dart';
import 'package:tests/Constants/constants.dart';

class showNotification extends StatefulWidget {
  const showNotification({super.key});

  @override
  State<showNotification> createState() => _showNotificationState();
}

class _showNotificationState extends State<showNotification> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationApi.init();
    listenNotification();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Center(child:  ElevatedButton(
              child: Text("test notification"), //click me button
              onPressed: () {
                NotificationApi.showNotification(title: "Facebook",body: "marwa wesleti a mentionner dans une status",payload: "marwa.obs");
              }),),
    );
  }
 void listenNotification() {
  NotificationApi.onNotification.stream.listen((String? payload) {
    onClickNotification(payload);
  });
}
  
  void onClickNotification(String? payload) {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => DetailsNotif()));
  }
}