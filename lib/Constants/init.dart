


import 'package:get/get.dart';
import 'package:tests/testProject/Data/Authentification.dart';
import 'package:tests/testProject/Data/ExerciceData.dart';
import 'package:tests/Constants/identifiant.dart';
import 'package:tests/testProject/Data/StatistiquesData.dart';
import 'package:tests/testProject/Data/homeData.dart';
import 'package:tests/testProject/Data/homeEnsData.dart';

Future<void> init ()async{
  Get.lazyPut(() => AuthService());
  Get.lazyPut(() => Identifiant());
  Get.lazyPut(() => ExerciceData());
  Get.lazyPut(() => HomePage());
  Get.lazyPut(() => StatistiquesData());
  Get.lazyPut(() => HomeEnsData());





}
