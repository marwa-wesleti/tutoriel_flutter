import 'package:get/get.dart';
import 'package:tests/Constants/constants.dart';
import 'package:tests/Constants/identifiant.dart';
import 'package:tests/testProject/Data/Authentification.dart';

class HomePage extends GetxController{
  // apprenant
   var nomUser = "".obs;
  var nivUser = "".obs;
  var percent4 = 0.obs;
  var percent5 = 0.obs;
  var percent6 = 0.obs;
  var niveauList = [{}].obs;
  var choixRegle="Toutes les régles".obs;
  var avatarSelected="saytoonz".obs;
  final AuthService authService=Get.find<AuthService>();
  final Identifiant identifiant = Get.find<Identifiant>();

  
  afficheData() async {
    print(identifiant.uidUser.value);
    Map<String, dynamic>? dataUser =
        await authService.getData("users", identifiant.uidUser.value);
    print(dataUser);
    nomUser.value = dataUser!["nomComplet"];
    nivUser.value = dataUser["niveauScolaire"];
    percent4.value = dataUser["percent4"];
    percent5.value = dataUser["percent5"];
    percent6.value = dataUser["percent6"];
    
     niveauList.value = [
      {"niveau": "4éme", "percent": percent4.value,"icon":"assets/icons/stat.png"},
      {"niveau": "5éme", "percent": percent5.value,"icon":"assets/icons/stat.png"},
      {"niveau": "6ème", "percent": percent6.value,"icon":"assets/icons/stat.png"},
    ];
   
  }

}