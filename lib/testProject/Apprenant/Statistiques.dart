import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tests/Constants/constants.dart';
import 'package:tests/testProject/Data/StatistiquesData.dart';

class Statistiques extends StatefulWidget {
  const Statistiques({super.key});

  @override
  State<Statistiques> createState() => _StatistiquesState();
}

class _StatistiquesState extends State<Statistiques> {
  late StatistiquesData statistiquesData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    statistiquesData = Get.find<StatistiquesData>();
    statistiquesData.addRegleEncousAcqui();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/backStat.PNG"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 250,
            ),
            Container(
              width: Get.width,
              height: Get.height / 2.3,
              child: CircularChart(),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.only(top: 10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                  mainAxisSpacing: 10,
                ),
                itemCount: statistiquesData.statics.value.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  if (index < statistiquesData.statics.value.length &&
                      statistiquesData.statics.value[index]["etat"] ==
                          "enCours") {
                    return Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Image(
                          image: AssetImage("assets/images/labelO.PNG"),
                        ),
                        addText(
                            statistiquesData.statics.value[index]["regle"]
                                ["titre"],
                            black,
                            true,
                            20,
                            false,
                            "schyler")
                      ],
                    );
                  } else {
                    return Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Image(
                          image: AssetImage("assets/images/labelG.PNG"),
                        ),
                        addText(
                            statistiquesData.statics.value[index]["regle"]
                                ["titre"],
                            black,
                            true,
                            20,
                            false,
                            "schyler")
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
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
          dataSource: <ChartData>[
            ChartData('Requis avant l\'entraînement', 0, kprimaryB),
            ChartData(
                'En cours d\'acquisition',
                (statistiquesData.regleEnCours.value.length *
                        100 /
                        statistiquesData.allRules.value.length)
                    .round()
                    .toDouble(),
                kprimaryO),
            ChartData(
                'Requis grâce à l\'entraînement',
                (statistiquesData.regleAcquis.value.length *
                        100 /
                        statistiquesData.allRules.value.length)
                    .round()
                    .toDouble(),
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
