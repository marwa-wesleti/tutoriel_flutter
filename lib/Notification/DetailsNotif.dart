import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tests/Constants/constants.dart';

class DetailsNotif extends StatefulWidget {
  const DetailsNotif({super.key});

  @override
  State<DetailsNotif> createState() => _DetailsNotifState();
}

class _DetailsNotifState extends State<DetailsNotif> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Center(child: Text("Welcom"),),
    );
  }
}