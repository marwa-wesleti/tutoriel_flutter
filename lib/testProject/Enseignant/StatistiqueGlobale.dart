import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tests/Constants/constants.dart';
import 'package:tests/testProject/Apprenant/Statistiques.dart';
import 'package:tests/testProject/Data/StatistiquesData.dart';
import 'package:tests/testProject/Data/homeEnsData.dart';

class StatistiqueGlobale extends StatefulWidget {
  const StatistiqueGlobale({super.key});

  @override
  State<StatistiqueGlobale> createState() => _StatistiqueGlobaleState();
}

class _StatistiqueGlobaleState extends State<StatistiqueGlobale> {
  late HomeEnsData homeEnsData;
  late StatistiquesData statistiquesData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeEnsData=Get.find<HomeEnsData>();
    statistiquesData=Get.find<StatistiquesData>();

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
            fit: BoxFit.fill
          )
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 120),
              child: addText(
                  "Statistiques de l\'apprenant  ", white, true, 30, false, "schyler"),
            ),
             Padding(
              padding: const EdgeInsets.only(top: 20),
              child: addText("${homeEnsData.userSelected.value["data"]["nomComplet"]}",
                  white, true, 25, false, "schyler"),
            ), 
            SizedBox(
              height: 150,
            ),
             Container(
              width: Get.width,
              height: Get.height / 2.3,
              child: CircularChart(),
            ),
          ]
        )
      ),
    );
  }
   Widget CircularChart() {
    return SfCircularChart(
      legend: Legend(
          height: "300",
          iconHeight: 20,
          iconWidth: 20,
          textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          position: LegendPosition.top,
          isVisible: true,
          toggleSeriesVisibility: false,
          overflowMode: LegendItemOverflowMode.wrap),
      series: <CircularSeries>[
        PieSeries<ChartData, String>(
          onPointTap: (pointInteractionDetails) async{
             if(pointInteractionDetails.pointIndex==0){
             await statistiquesData.getAllRule("4éme");
             await  homeEnsData.getRegleAcquisApp(homeEnsData.userSelected.value["uid"], "4éme");
             Get.to(() =>Statistiques());
             }
             if(pointInteractionDetails.pointIndex==1){
              print(pointInteractionDetails.viewportPointIndex);
             }

            
          },
          dataSource: <ChartData>[
            ChartData('Niveau 4ème',double.parse( homeEnsData.userSelected.value["data"]["percent4"].toString()), kprimaryB),
            ChartData(
                'Niveau 5ème', double.parse( homeEnsData.userSelected.value["data"]["percent5"].toString()),
                kprimaryO),
            ChartData(
                'Niveau 6ème', double.parse( homeEnsData.userSelected.value["data"]["percent6"].toString()),
                kprimaryG),
          ],
          xValueMapper: (ChartData data, _) => data.category,
          yValueMapper: (ChartData data, _) => data.value,
          pointColorMapper: (ChartData data, _) => data.color,
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          dataLabelMapper: (ChartData data, _) =>data.value.toInt()!=0?'${data.value.toInt()}%':' ',
               // Ajoutez % pour afficher le pourcentage
        ),
      ],
    );
  }
}

class ChartData {
  ChartData(this.category, this.value, this.color);

  final String category;
  final double value;
  final Color color;
}