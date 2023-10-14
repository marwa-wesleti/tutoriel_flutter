import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tests/Constants/constants.dart';
import 'package:tests/testProject/Data/homeEnsData.dart';
import 'package:tests/testProject/Enseignant/detailsApp.dart';

class HomeEns extends StatefulWidget {
  const HomeEns({super.key});

  @override
  State<HomeEns> createState() => _HomeEnsState();
}

class _HomeEnsState extends State<HomeEns> {
  late HomeEnsData homeEnsData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeEnsData=Get.find<HomeEnsData>();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/enseignant/backEns.PNG"),
                  fit: BoxFit.fill)),
          child: RefreshIndicator(
        onRefresh: () {
        return  homeEnsData.getAllApprenant();
        },
        child:
           Container(
              margin: EdgeInsets.only(top: 100),
              padding: EdgeInsets.only(top: 200),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage("assets/images/enseignant/calendar.PNG"))),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: addText("TOTAL", black, true, 50, false, "schyler"),
                    ),
                    addText("${homeEnsData.allApp.value.length} Apprenants", black, true, 40, false, "schyler"),
                   
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                homeEnsData.niveauSelected.value="5ème";
                                homeEnsData.selectedList.value=homeEnsData.app5.value;
                                Get.to(()=>detailsApp());
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image(
                                    image: AssetImage(
                                        "assets/images/enseignant/etiquette5.PNG"),
                                    width: 150,
                                    height: 150,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 60),
                                    child: addText(
                                        "${homeEnsData.app5.value.length}", black, true, 25, false, "schyler"),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                homeEnsData.niveauSelected.value="6ème";
                                
                                homeEnsData.selectedList.value=homeEnsData.app6.value;
                                print(homeEnsData.selectedList.value);
                                Get.to(()=>detailsApp());
                                
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image(
                                    image: AssetImage(
                                        "assets/images/enseignant/etiquette6.PNG"),
                                    width: 150,
                                    height: 150,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 60),
                                    child: addText(
                                        "${homeEnsData.app6.value.length}", black, true, 25, false, "schyler"),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
        ),
      ),
    );
  }
}
