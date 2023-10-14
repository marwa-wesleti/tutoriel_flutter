import 'dart:io';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/search_bar/gf_search_bar.dart';
import 'package:tests/Constants/constants.dart';
import 'package:tests/testProject/Apprenant/Exercice.dart';
import 'package:tests/testProject/Apprenant/Statistiques.dart';
import 'package:tests/testProject/Data/ExerciceData.dart';
import 'package:tests/Constants/identifiant.dart';
import 'package:tests/testProject/Data/StatistiquesData.dart';
import 'package:tests/testProject/Data/homeData.dart';
import 'package:random_avatar/random_avatar.dart';

class PageNiveau extends StatefulWidget {
  const PageNiveau({super.key});

  @override
  State<PageNiveau> createState() => _PageNiveauState();
}

class _PageNiveauState extends State<PageNiveau> {
  late ExerciceData exerciceData;
  late HomePage homeData;

  var pathImage = "assets/icons/fleche.PNG".obs;
  var colorText = kprimaryO.obs;
  final Identifiant identifiant = Get.find<Identifiant>();
  late StatistiquesData statistiquesData;
  var listAvatars = [].obs;
  var loading=false.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listAvatars.value = [
      "saytoonz",
      "0be0ea02e75ea8424ddf",
      "497fa8b6f7655a1311",
      "c9a416a571bacf1176",
      "d6b5eb3279d1b38ebb",
      "fe23e891223bb3f16b",
    ];
    exerciceData = Get.find<ExerciceData>();
    homeData = Get.find<HomePage>();
    statistiquesData = Get.find<StatistiquesData>();

    homeData.afficheData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/backNivPage.PNG"),
                fit: BoxFit.fill)),
        child: RefreshIndicator(
          onRefresh: () async {
            await homeData
                .afficheData(); // Mettre à jour les données depuis Firebase
          },
          child: Obx(
            () => Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(top: 30, right: 20),
                  child: IconButton(
                      onPressed: () async {
                        homeData.authService.logout(context);
                      },
                      icon: Icon(
                        Icons.logout_outlined,
                        color: white,
                        size: 50,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 20),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            addSnackBar(
                                context,
                                "Choisir votre Avatar",
                                100,
                                200,
                                Column(
                                  children: [
                                    Expanded(
                                      child: GridView.builder(
                                          padding: EdgeInsets.only(top: 0),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            childAspectRatio: 1,
                                            mainAxisSpacing: 20,
                                          ),
                                          itemCount: listAvatars.value.length,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                homeData.avatarSelected.value =
                                                    listAvatars.value[index];
                                                print(homeData
                                                    .avatarSelected.value);
                                                Get.back();
                                              },
                                              child: randomAvatar(
                                                  listAvatars.value[index],
                                                  trBackground: true),
                                            );
                                          }),
                                    ),
                                  ],
                                ));
                          },
                          child: randomAvatar(homeData.avatarSelected.value,
                              height: 100, width: 100)),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            addText(homeData.nomUser.value, white, true, 25,
                                false, "schyler"),
                            SizedBox(height: 10.0),
                            addText("Niveau : ${homeData.nivUser.value}", white,
                                true, 20, false, "schyler")
                          ]),
                    ],
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                addText("Mon Programme d'entraînement", black, true, 25, false,
                    "shyler"),
                Obx(
                  () => Expanded(
                    child: ListView.builder(
                        itemCount: homeData.niveauList
                            .length, // Nombre d'éléments dans votre liste
                        itemBuilder: (context, index) {
                          return IgnorePointer(
                            ignoring: (index > 0 &&
                                homeData.niveauList.value[index - 1]
                                        ["percent"] !=
                                    100),
                            child: Opacity(
                              opacity: (index > 0 &&
                                      homeData.niveauList.value[index - 1]
                                              ["percent"] !=
                                          100)
                                  ? 0.4
                                  : 1.0,
                              child: Column(
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    height: Get.height * 0.15,
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: kprimaryB,
                                            style: BorderStyle.solid,
                                            width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        addText(
                                            "Niveau ${homeData.niveauList.value[index]["niveau"]}",
                                            black,
                                            true,
                                            30,
                                            false,
                                            "schyler"),
                                        Spacer(),
                                        addText(
                                            "${homeData.niveauList.value[index]["percent"]}%",
                                            homeData.niveauList.value[index]
                                                        ["percent"] ==
                                                    100
                                                ? kprimaryG
                                                : kprimaryO,
                                            true,
                                            25,
                                            false,
                                            "schyler"),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            if (homeData.niveauList.value[index]
                                                    ["percent"] ==
                                                0) {
                                              addSnackBar(
                                                  context,
                                                  "Commencer par :",
                                                  Get.width / 1.5,
                                                  Get.height / 6,
                                                  Obx(
                                                    () => Column(
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: RadioListTile(
                                                            title: addText(
                                                                "Toutes les régles",
                                                                black,
                                                                false,
                                                                20,
                                                                false,
                                                                ""),
                                                            value:
                                                                "Toutes les régles",
                                                            groupValue: homeData
                                                                .choixRegle
                                                                .value,
                                                            onChanged: (value) {
                                                              homeData.choixRegle
                                                                      .value =
                                                                  value
                                                                      .toString();
                                                              print(homeData
                                                                  .choixRegle
                                                                  .value);
                                                            },
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: RadioListTile(
                                                            title: addText(
                                                                "Par Etape",
                                                                black,
                                                                false,
                                                                20,
                                                                false,
                                                                ""),
                                                            value: "Par Etape",
                                                            groupValue: homeData
                                                                .choixRegle
                                                                .value,
                                                            onChanged: (value) {
                                                              homeData.choixRegle
                                                                      .value =
                                                                  value
                                                                      .toString();
                                                              print(homeData
                                                                  .choixRegle
                                                                  .value);
                                                            },
                                                          ),
                                                        ),
                                                        Expanded(
                                                            flex: 1,
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child:loading.value?Center(child: CircularProgressIndicator(),)
                                                               :TextButton(
                                                                onPressed:
                                                                    () async {
                                                                      loading.value=true;
                                                                       exerciceData.percentNiv.value = homeData
                                                                        .niveauList
                                                                        .value[
                                                                            index]
                                                                            [
                                                                            "percent"]
                                                                        .toDouble();
                                                                        
                                                                  if (homeData.choixRegle.value =="Toutes les régles"){
                                                                      exerciceData.allRegle.value=true;
                                                                  } 
                                                                      
                                                                  else {exerciceData.allRegle.value=false;}
                                                                await exerciceData.getListPhrase(homeData.niveauList.value[index]["niveau"]);  
                                                               
                                                                  exerciceData
                                                                        .nivAct
                                                                        .value = homeData
                                                                            .niveauList
                                                                            .value[index]
                                                                        [
                                                                        "niveau"];
                                                                    print(homeData
                                                                            .niveauList
                                                                            .value[index]
                                                                        [
                                                                        "niveau"]);
                                                                    await exerciceData.getStatistique(homeData
                                                                            .niveauList
                                                                            .value[index]
                                                                        [
                                                                        "niveau"]);
                                                                    print(
                                                                        "list phrase");
                                                                    print(exerciceData
                                                                        .listRegle
                                                                        .value);
                                                                    print(
                                                                        "Regleacquise: ${exerciceData.regleAcquises}");
                                                                        loading.value=false;
                                                                        Navigator.pop(context);
                                                                        Get.to(() => Exercice());
                                                                        
                                                                },
                                                                child: addText(
                                                                    "Appliquer",
                                                                    kprimaryB,
                                                                    true,
                                                                    20,
                                                                    false,
                                                                    ""),
                                                              ),
                                                            ))
                                                      ],
                                                    ),
                                                  ));
                                            }
                                            if (homeData.niveauList.value[index]
                                                    ["percent"] !=
                                                100) {
                                                   exerciceData.percentNiv.value = homeData
                                                                        .niveauList
                                                                        .value[
                                                                            index]
                                                                            [
                                                                            "percent"]
                                                                        .toDouble();
                                                                         await exerciceData.getListPhrase(homeData.niveauList.value[index]["niveau"]);  
                                                               
                                                                  exerciceData
                                                                        .nivAct
                                                                        .value = homeData
                                                                            .niveauList
                                                                            .value[index]
                                                                        [
                                                                        "niveau"];
                                                                    print(homeData
                                                                            .niveauList
                                                                            .value[index]
                                                                        [
                                                                        "niveau"]);
                                                                    await exerciceData.getStatistique(homeData
                                                                            .niveauList
                                                                            .value[index]
                                                                        [
                                                                        "niveau"]);
                                                                    print(
                                                                        "list phrase");
                                                                    print(exerciceData
                                                                        .listRegle
                                                                        .value);
                                                                    print(
                                                                        "Regleacquise: ${exerciceData.regleAcquises}");
                                                                        loading.value=false;
                                                                        Navigator.pop(context);
                                                                        Get.to(() => Exercice());
                                            } else {
                                              await statistiquesData.getAllRule(
                                                  homeData.niveauList
                                                      .value[index]["niveau"]);
                                              await statistiquesData
                                                  .getRegleAcquis(homeData
                                                      .niveauList
                                                      .value[index]["niveau"]);

                                              Get.to(() => Statistiques());
                                            }
                                          },
                                          child: Image(
                                            image: index < 3 &&
                                                    homeData.niveauList
                                                                .value[index]
                                                            ["percent"] ==
                                                        100
                                                ? AssetImage(homeData.niveauList
                                                    .value[index + 1]["icon"])
                                                : AssetImage(
                                                    "assets/icons/fleche.PNG"),
                                            width: 30,
                                            height: 30,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: kprimaryB,
        items: const <Widget>[
          Icon(Icons.home_outlined,
              size: 30, color: Color.fromARGB(255, 46, 85, 155)),
          Image(
            image: AssetImage(
              'assets/icons/stat.png',
            ),
            width: 30,
            height: 30,
            color: Color.fromARGB(255, 46, 85, 155),
          ),
          Image(
            image: AssetImage(
              'assets/icons/stat.png',
            ),
            width: 30,
            height: 30,
            color: white,
          ),
        ],
        onTap: (index) {
          //Handle button tap
          setState(() {
            switch (index) {
              case 0:
                break;
              case 1:
                {}
                break;
            }
          });
        },
      ),
    );
  }
}
