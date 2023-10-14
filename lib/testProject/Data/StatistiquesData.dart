import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tests/Constants/identifiant.dart';


class StatistiquesData extends GetxController {
  var allRules = [{}].obs;
  var regleAcquis = [{}].obs;
  var regleEnCours = [{}].obs;
  var statics=[{}].obs;

  final Identifiant identifiant=Get.find<Identifiant>();

  Future<Map<dynamic, dynamic>?> getAllRule(String niveau) async {
    allRules.value=[];
    try {
      QuerySnapshot queryRegleSnapshot = await FirebaseFirestore.instance
          .collection("niveau")
          .doc(niveau)
          .collection("régle")
          .get();
      if (queryRegleSnapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot docRegle in queryRegleSnapshot.docs) {
          Map<dynamic, dynamic> regleData =
              docRegle.data() as Map<dynamic, dynamic>;
          if (allRules.value.isEmpty) {
            allRules.value.add({"idRegle": docRegle.id, "Regle": regleData});
          } else if (!(allRules.value.contains(docRegle.id))) {
            allRules.value.add({"idRegle": docRegle.id, "Regle": regleData});
          }
        }
      }
    } catch (e) {
      return null;
    }
  }

  Future<Map<dynamic, dynamic>?> getRegleAcquis(String niveau) async {
     regleAcquis.value=[];
    try {
      QuerySnapshot queryRegleAcquisSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(identifiant.uidUser.value)
          .collection("statistiques")
          .doc(niveau)
          .collection("RegleAcquises")
          .get();
      if (queryRegleAcquisSnapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot docRegleAcquis in queryRegleAcquisSnapshot.docs) {
          Map<dynamic, dynamic> regleData =
              docRegleAcquis.data() as Map<dynamic, dynamic>;
          if (regleAcquis.value.isEmpty) {
            regleAcquis.value.add({"idRegle": docRegleAcquis.id, "Regle": regleData});
          } else if (!(regleAcquis.value.contains(docRegleAcquis.id))) {
            regleAcquis.value.add({"idRegle": docRegleAcquis.id, "Regle": regleData});
          }
        }

      }
    } catch (e) {
      return null;
    }
  }

  void addRegleEncousAcqui(){
    statics.value=[];
    regleEnCours.value=[];
  print(allRules);
  print(regleAcquis);

for (Map<dynamic, dynamic> reg in allRules) {
  if (!regleAcquis.value.any((element) =>  reg["idRegle"] == element["idRegle"])) {
    regleEnCours.add(reg);
    statics.add(
      
      {
        "idRegle":reg["idRegle"],
        "regle":reg["Regle"],
        "etat":"enCours",
        
      }
    );
  }
  else{
    statics.add(
      
      {
        "idRegle":reg["idRegle"],
        "regle":reg["Regle"],
        "etat":"requis",
        
      }
    );
  }

}

  print(statics);

  print(regleEnCours);

}
}