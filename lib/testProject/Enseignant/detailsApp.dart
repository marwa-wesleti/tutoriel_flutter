import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:tests/Constants/constants.dart';
import 'package:tests/testProject/Apprenant/Statistiques.dart';
import 'package:tests/testProject/Data/homeEnsData.dart';
import 'package:tests/testProject/Enseignant/StatistiqueGlobale.dart';

class detailsApp extends StatefulWidget {
  const detailsApp({super.key});

  @override
  State<detailsApp> createState() => _detailsAppState();
}

class _detailsAppState extends State<detailsApp> {
  late HomeEnsData homeEnsData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeEnsData = Get.find<HomeEnsData>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/enseignant/backDetails.PNG"),
                fit: BoxFit.fill)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 120),
              child: addText(
                  "Listes des apprenants", white, true, 30, false, "schyler"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: addText("Niveau \"${homeEnsData.niveauSelected.value}\"",
                  white, true, 25, false, "schyler"),
            ),
            SizedBox(
              height: 50,
            ),
            Expanded(
                child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 1, mainAxisSpacing: 20),
              padding: EdgeInsets.only(top: 10),
              itemCount: homeEnsData.selectedList.value.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async{
                   await homeEnsData.getStatistiqueUser(homeEnsData.selectedList.value[index]["uid"]);
                    Get.to(()=>StatistiqueGlobale());
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: homeEnsData.selectedList.value[index]["user"]["genre"] =="masculin"
                            ? randomAvatar("saytoonz", trBackground: true)
                            : randomAvatar("a119d31311dab54d92",
                                trBackground: true),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      addText(homeEnsData.selectedList.value[index]["user"]["nomComplet"], black, true, 16, false, "schyler")
                    ],
                  ),
                );
              },
             
            )),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
