import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:tests/Constants/constants.dart';
import 'package:tests/Constants/identifiant.dart';

class ExerciceData extends GetxController{
var taillePhrase=0.obs; 
var tailleAllRegle=0.obs;
var tailleRegAcq=0.obs; 
var allRegle=false.obs;
var listPhrase=[{}].obs;
var listRegle=[{}].obs;
var isUnderlined = false.obs;
var currentIndexRegle=0.obs;
var currentIndexPhrase=0.obs;
var resultAi={}.obs;
var erreur="".obs;
var etatResponseUser=false.obs;
var percent=0.obs;
var motIncorrect="".obs;
var solution="".obs;
var successiveCorrectAnswers = [{}].obs;
var idRegleacquise="".obs;
final Identifiant identifiant=Get.find<Identifiant>();
var regleAcquises=[{}].obs;
var percentNiv=0.0.obs;
var nivAct="".obs;
 final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users'); 


Future<void> getListPhrase( String idDoc) async {
  int currentMonth=DateTime.now().month;
  listPhrase.value=[];
  listRegle.value=[];
  taillePhrase.value=0;
   QuerySnapshot queryRegleSnapshot ;
  try {
queryRegleSnapshot = await FirebaseFirestore.instance.collection("niveau").doc(idDoc).collection("régle").get();
tailleAllRegle.value=queryRegleSnapshot.docs.length;
if(!allRegle.value){
 queryRegleSnapshot = await FirebaseFirestore.instance.collection("niveau").doc(idDoc).collection("régle").where("dispo",isLessThanOrEqualTo: currentMonth).get();

}
  for (QueryDocumentSnapshot docRegle in queryRegleSnapshot.docs) {
    Map<String, dynamic> regleData = docRegle.data() as Map<String, dynamic>;
    if(listRegle.value.isEmpty){
        listRegle.value.add({"idRegle":docRegle.id,"Regle":regleData});

    }
    else if(!(listRegle.value.contains(docRegle.id))){
        listRegle.value.add({"idRegle":docRegle.id,"Regle":regleData});
    }
  
    
    QuerySnapshot queryPhraseSnapshot = await docRegle.reference.collection("phrases").get();
    
    for (QueryDocumentSnapshot docPhrase in queryPhraseSnapshot.docs) {
      Map<String, dynamic> phraseData = docPhrase.data() as Map<String, dynamic>;

      if (regleData.isNotEmpty && phraseData.isNotEmpty) {
        listPhrase.value.add({
          "idRegle":docRegle.id,
          "regle": regleData,
          "idPhrase":docPhrase.id,
          "phrase": phraseData,
        });

      taillePhrase.value++;

      }
    }
  }
 
  print(listRegle.value);
  listPhrase.value.shuffle();
  print(listPhrase.value);
  update();
} catch (e) {
  print(e);
}


  }


   Future<Map<dynamic, dynamic>?> checkAiSpelling(String text) async {
    resultAi.value={};
  final apiKey = 'CFnLHBw4CpjwnjJY'; // votre clé API TextGears
  final apiUrl = 'https://api.textgears.com/spelling'; //based url

  try {
    final response = await http.post(Uri.parse(apiUrl), body: {
    'text': text,
    'language': 'fr-FR', // Langue française
    'ai': '1', // Utiliser l'intelligence artificielle
    'key': apiKey,
  });
  if (response.statusCode == 200) {
    resultAi.value = json.decode(response.body);
    print(resultAi.value);
    return resultAi.value;
  }
  } catch (e) {

  }
}

 int getIndexRegle(String idRegle){
    for(int i=0;i<listRegle.length;i++){
        if(listRegle.value[i]["idRegle"]==idRegle){
          currentIndexRegle.value=i;
        }
    }
    print(currentIndexRegle.value);

    return currentIndexRegle.value;
 }

 void validateResultUser(String word,Map<dynamic,dynamic> phrase,Map<dynamic,dynamic> rule ){
  if(resultAi.value["status"]!=null &&resultAi.value["status"]){
    if(resultAi.value["response"]["errors"].length==0){
       erreur.value="il n'y a pas de faute";
        motIncorrect.value="";

      print("il n'y a pas de faute");
      if(word.isNotEmpty){
        etatResponseUser.value=false;
        print("failed");
        onAnswerSubmitted(rule);
        listPhrase.removeAt(currentIndexPhrase.value);
        listPhrase.add(phrase);
      }
      else{
        etatResponseUser.value=true;
        percent.value++;

        onAnswerSubmitted(rule);
        print("bravo");
      }
     

    }
    else{
      erreur.value="il y'a de faute";
      print("il y'a de faute");
      if(resultAi.value["response"]["errors"][0]["bad"]==word){
        etatResponseUser.value=true;
        percent.value++;

        print("bravo");
        onAnswerSubmitted(rule);
        solution.value=resultAi.value["response"]["errors"][0]["better"][0];
        motIncorrect.value=resultAi.value["response"]["errors"][0]["bad"];

        print(solution.value);

      }
      else{
        etatResponseUser.value=false;
        print("failed");
        onAnswerSubmitted(rule);
        solution.value=resultAi.value["response"]["errors"][0]["better"][0];
        motIncorrect.value=resultAi.value["response"]["errors"][0]["bad"];

        print(solution.value);
         listPhrase.removeAt(currentIndexPhrase.value);

        listPhrase.add(phrase);

      }
    }
     print("liste phrase");
        print(listPhrase);
  }
  else{
    print("erreur de vérification");
  }

 }

 void onAnswerSubmitted( Map<dynamic,dynamic> rule) {
    print(successiveCorrectAnswers.value);
    if(etatResponseUser.value){
    if(successiveCorrectAnswers.value.isEmpty){
      successiveCorrectAnswers.add(
        {
          "idRegle":rule["idRegle"],
          "succ":1
        }
      );
    }
    else{
    bool ruleExists = false;

  for (Map<dynamic, dynamic> succ in successiveCorrectAnswers.value) {
    if ( succ["idRegle"] == rule["idRegle"]) {
      succ["succ"] = succ["succ"] + 1;
      ruleExists = true;

      if (succ["succ"] == 2) {
        // Marquer la règle comme acquise pour l'utilisateur
        print("Règle acquise");
        idRegleacquise.value=succ["idRegle"];
        regleAcquises.value.add(rule);
        listPhrase.value.removeWhere((element) => element["idRegle"]==rule["idRegle"]);
      print("aprés la supprision");
      print(listPhrase.value);
      print(regleAcquises.value);
      print(listRegle.value);
       addStat(); 
        // Mettre à jour les statistiques de l'utilisateur
      }

      break; // Sortir de la boucle une fois que la règle a été trouvée
    }
  }

  if (!ruleExists) {
    // Si la règle n'a pas été trouvée, ajoutez-la
    successiveCorrectAnswers.add({
      "idRegle": rule["idRegle"],
      "succ": 1,
    });
  }
}
}
else{
  if(successiveCorrectAnswers.value.isEmpty){
      successiveCorrectAnswers.add(
        {
          "idRegle":rule["idRegle"],
          "succ":0
        }
      );
    }
    else{
    bool ruleExists = false;

  for (Map<dynamic, dynamic> succ in successiveCorrectAnswers.value) {
    if ( succ["idRegle"] == rule["idRegle"]) {
      succ["succ"] =0;
      ruleExists = true;
      
      break;
      
    }
  }

  if (!ruleExists) {
    // Si la règle n'a pas été trouvée, ajoutez-la
    successiveCorrectAnswers.add({
      "idRegle": rule["idRegle"],
      "succ": 0,
    });
  }
}
}
}

Future<void> updatePercent() async{
  percentNiv.value=(regleAcquises.value.length*100)/tailleAllRegle.value;
  try {
     DocumentReference documentUser = await userCollection.doc(identifiant.uidUser.value);
     if(nivAct.value=="4éme"){
      await documentUser.update({
      "percent4":percentNiv.value.round() ,
    });
    }
    else if(nivAct.value=="5éme"){
       await documentUser.update({
      "percent5": percentNiv.value.round(),
    });

    }
    else{
         await documentUser.update({
      "percent6": percentNiv.value.round(),
    });
    }

      
  } catch (e) {
    
  }
} 

Future<void> addStat () async{
  try {
 QuerySnapshot statData=await userCollection
                        .doc(identifiant.uidUser.value)
                        .collection("statistiques")
                        .doc(nivAct.value)
                        .collection("RegleAcquises").get();
    if(statData.docs.isNotEmpty){
      for(Map<dynamic,dynamic> reg in regleAcquises.value){
        if(!(statData.docs.any((element) => element==reg["idRegle"]))){
          await userCollection
          .doc(identifiant.uidUser.value)
          .collection("statistiques")
          .doc(nivAct.value)
          .collection("RegleAcquises")
          .doc(reg["idRegle"]) 
          .set(reg["Regle"]);
        }
        print("regles existe");
      }
      print("success cas1");
    }
    else{
      for(Map<dynamic,dynamic> reg in regleAcquises.value){
        
          await userCollection
          .doc(identifiant.uidUser.value)
          .collection("statistiques")
          .doc(nivAct.value)
          .collection("RegleAcquises")
          .doc(reg["idRegle"]) 
          .set(reg["Regle"]);
        
      }
      print("success cas2");
    
    }
  } catch (e) {
    print(e);
    
  }
}

 Future<void> getStatistique(String niveau)async{
  regleAcquises.value=[];
  try {
     QuerySnapshot statData=await userCollection
                        .doc(identifiant.uidUser.value)
                        .collection("statistiques")
                        .doc(niveau)
                        .collection("RegleAcquises").get();
    if(statData.docs.isNotEmpty){
      for(QueryDocumentSnapshot stat in statData.docs){
        Map<String,dynamic> data=stat.data() as Map<String,dynamic>;
        regleAcquises.value.add({
          "idRegle":stat.id,
          "Regle":data
        });
        listPhrase.value.removeWhere((element) => element["idRegle"]==stat.id);
        taillePhrase.value=listPhrase.value.length;
      }
      print(regleAcquises.value);
      print(listPhrase.value);
    }
  } catch (e) {
    
  }
} 
}