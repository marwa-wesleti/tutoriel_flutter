import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tests/Constants/constants.dart';
import 'package:tests/testProject/Apprenant/AppHome1.dart';
import 'package:tests/Constants/identifiant.dart';
import 'package:tests/testProject/Auth/login.dart';
import 'package:tests/testProject/Data/homeEnsData.dart';
import 'package:tests/testProject/Enseignant/homeEns.dart';

class AuthService extends GetxController {

   //signin
  TextEditingController authEmailController = TextEditingController();
  TextEditingController authMdpController = TextEditingController();

  //signup
  TextEditingController nomController = TextEditingController();
  TextEditingController tlfController = TextEditingController();
  TextEditingController nivController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mdpController = TextEditingController();
  var dropDownTypeValue = "Apprenant".obs;
  var genre="masculin".obs;

//Firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;
   final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');
     
  final Identifiant identifiant=Get.put(Identifiant());

  var enableErreur=false.obs;
  var erreur="".obs;

  HomeEnsData homeEnsData=Get.find<HomeEnsData>();  
    

  Future<void> signUp(BuildContext context) async {
    addSnackBar(context,"Chargememnt ....",100,50, Column(children: [CircularProgressIndicator()],));
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: mdpController.text,
      );
       
       Map<String, dynamic> userData ={
        'nomComplet': nomController.text.capitalizeFirst,
        'genre':genre.value,
        'email': emailController.text,
        'role': dropDownTypeValue.value,
        'telephone': tlfController.text,
        'mdp':mdpController.text
      };

      if (dropDownTypeValue.value == "Apprenant") {
        userData['niveauScolaire'] = nivController.text;
        userData['percent4'] = 0;
        userData['percent5'] = 0;
        userData['percent6'] = 0;

        await _usersCollection.doc(userCredential.user!.uid).set(userData);
          Get.back();
      
         await _auth.setLanguageCode('fr');
      await userCredential.user!.sendEmailVerification();// yaab3eth lel user email de vérification
      addToast("Un e-mail de vérification a été envoyé à ${emailController.text}");

        
        
        
      } else {
        await _usersCollection.doc(userCredential.user!.uid).set(userData);
          Get.back();
      
         await _auth.setLanguageCode('fr');
      await userCredential.user!.sendEmailVerification();// yaab3eth lel user email de vérification
      addToast("Un e-mail de vérification a été envoyé à ${emailController.text}");

        
        
        
      }
      
          Get.to(()=>login());
        dropDownTypeValue.value = 'Apprenant';
        nivController.text = "";
        nomController.text = "";
        tlfController.text = "";
        
    }on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      if (e.code == 'email-already-in-use') {
        addToast("email existe déjà");
      }
       if (e.code == 'invalid-email') {
        addToast("adresse email n'est pas valide");
      }

    } catch (e) {
        print(e);
    }
  }


  Future<void> signIn(BuildContext context) async {
    addSnackBar(context,"Chargememnt ....",100,50,Column(children: [CircularProgressIndicator()],));
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: authEmailController.text,
        password: authMdpController.text,
      );
      if(userCredential.user!.emailVerified==true){
        User user=userCredential.user!;
        if (user != null) {
        identifiant.uidUser.value=user.uid; 
        identifiant.users.value[user.uid] =user;  
        Map<String, dynamic>? dataUser = await getData("users",user.uid);
        print(dataUser);
        
        if (dataUser!["Role"] == "Apprenant") {
          Get.off(() => AppHome1());
          
        } 
        if (dataUser["Role"] == "Enseignant")  {
          await  homeEnsData.getAllApprenant();
            Get.off(() => HomeEns());
        }
        erreur.value="";
          enableErreur.value=false;
        authEmailController.text = "";
        authMdpController.text = "";
      
      
    } else {
       Navigator.of(context).pop();
       enableErreur.value=true;
       erreur.value="Erreur de connexion";
      
    }

      }
      else{
         Navigator.of(context).pop();
          enableErreur.value=true;
       erreur.value="Votre email n'est pas vérifié";
        
      }

      
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      if (e.code == 'user-not-found') {
          enableErreur.value=true;
       erreur.value="Aucun utilisateur n'existe";
      }
      if (e.code == 'wrong-password') {
          enableErreur.value=true;
       erreur.value="Mot de passe incorrect";
      }
      if (e.code == 'invalid-email') {
          enableErreur.value=true;
       erreur.value="adresse email n'est pas valide";
      }

    }
     catch (e) {
    }
  }

    Future<void> sendREsetPassword(String email) async {
    try {
    
        // Utilisateur trouvé
        await _auth.setLanguageCode('fr');
        await _auth.sendPasswordResetEmail(email: email).then((value) => Get.back() );

        addToast("Un e-mail de réinitialisation a été envoyé à $email");
     
    }on FirebaseAuthException catch (e) {
      if (e.code == 'auth/user-not-found') {
        addToast("email existe déjà");
      }
       if (e.code == 'auth/invalid-email') {
        addToast("adresse email n'est pas valide");
      }

    }
    
     catch (e) {
      addToast(
          'Une erreur s\'est produite lors de l\'envoi de l\'e-mail de réinitialisation.');
    }
  }

  Future<Map<String, dynamic>?> getData(String collection, String idDoc) async {
    try {
      DocumentSnapshot documentUser = await FirebaseFirestore.instance.collection(collection).doc(idDoc).get();
      if (documentUser.exists) {
        Map<String, dynamic> data = documentUser.data() as Map<String, dynamic>;
        return data;

      }
    } catch (e) {
      return null;
    }
  }

  Future<void> logout(BuildContext context) async {
    showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        "Vérification",
        style: TextStyle(fontSize: 20),
      ),
      content: Text("Vous pouvez le déconnecter ?", style: TextStyle(fontSize: 16)),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: addText("Non", kprimaryB, true, 16, false, "schyer"),
        ),
        TextButton(
          onPressed:() async {
            Navigator.pop(context);
             await _auth.signOut(); 
             Get.to(()=>login());
          },
          child: addText("Oui", kprimaryB, true, 16, false, "schyer"),
        ),
      ],
    ));
     
  }

}