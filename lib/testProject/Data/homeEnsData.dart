import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeEnsData extends GetxController{

CollectionReference users=FirebaseFirestore.instance.collection("users");
var allApp=[{}].obs;
var app5=[{}].obs;
var app6=[{}].obs;
var selectedList=[{}].obs;
var niveauSelected="".obs;
var userSelected={}.obs;
var regleAcquisApp=[{}].obs;




Future<void> getAllApprenant() async{
  allApp.value=[];
  app5.value=[];
  app6.value=[];

  try {
   final QuerySnapshot listApp=await users.get();
    for(QueryDocumentSnapshot doc in listApp.docs.where((element) => element["Role"]=="Apprenant")){
       Map<dynamic,dynamic> data=doc.data() as Map<dynamic,dynamic>;
      allApp.value.add(data);
      if(data["niveauScoraire"]=="5ème"){
        app5.add({
          "uid":doc.id,
          "user":data
        });
      }
      else{
         app6.add({
          "uid":doc.id,
          "user":data
        });
      }
    }
    print(allApp.value);
    print("list 5éme: ${app5.value}");
    print("list 6éme: ${app6.value}");


  } catch (e) {
    
  }
  update();
}

Future<void> getStatistiqueUser(String uidUser)async{
  try {
   DocumentSnapshot documentReference =await FirebaseFirestore.instance.collection("users").doc(uidUser).get();
   if(documentReference.exists){
    Map<dynamic,dynamic> data=documentReference.data() as Map<dynamic,dynamic>;
     userSelected.value={"uid":uidUser,"data":data};
     print(userSelected.value);
   }
    
  } catch (e) {
    
  }
}

 Future<Map<dynamic, dynamic>?> getRegleAcquisApp(String uidApp, String niveau) async {
     regleAcquisApp.value=[];
    try {
      QuerySnapshot queryRegleAcquisSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(uidApp)
          .collection("statistiques")
          .doc(niveau)
          .collection("RegleAcquises")
          .get();
      if (queryRegleAcquisSnapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot docRegleAcquis in queryRegleAcquisSnapshot.docs) {
          Map<dynamic, dynamic> regleData =
              docRegleAcquis.data() as Map<dynamic, dynamic>;
          if (regleAcquisApp.value.isEmpty) {
            regleAcquisApp.value.add({"idRegle": docRegleAcquis.id, "Regle": regleData});
          } else if (!(regleAcquisApp.value.contains(docRegleAcquis.id))) {
            regleAcquisApp.value.add({"idRegle": docRegleAcquis.id, "Regle": regleData});
          }
        }

      }
    } catch (e) {
      return null;
    }
  }



}