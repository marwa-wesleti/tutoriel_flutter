import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:tests/Constants/constants.dart';
import 'package:tests/testProject/Apprenant/NivPage.dart';
import 'package:tests/testProject/Apprenant/Statistiques.dart';
import 'package:tests/testProject/Data/ExerciceData.dart';
import 'package:tests/testProject/Data/StatistiquesData.dart';
import 'package:tests/testProject/Data/homeData.dart';

class Exercice extends StatefulWidget {
  const Exercice({super.key});

  @override
  State<Exercice> createState() => _ExerciceState();
}

class _ExerciceState extends State<Exercice> {
  late ExerciceData exerciceData;
  late HomePage homePage;
  late StatistiquesData statistiquesData;

  late List<String> words;
  var phraseCorrect = "".obs;
  var enable = false.obs;
  var regCrucial = false.obs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homePage = Get.find<HomePage>();
    exerciceData = Get.find<ExerciceData>();
    statistiquesData = Get.find<StatistiquesData>();

    words = exerciceData.listPhrase.value[0]["phrase"]["textPhrase"]
        .split(' '); // Divisez la première phrase en mots
    exerciceData.getIndexRegle(exerciceData.listPhrase.value[0]["idRegle"]);
    exerciceData.checkAiSpelling(
        exerciceData.listPhrase.value[0]["phrase"]["textPhrase"]);
    exerciceData.etatResponseUser.value = false;
    exerciceData.currentIndexPhrase.value = 0;
    exerciceData.percent.value = 0;
    exerciceData.isUnderlined.value = false;
    exerciceData.successiveCorrectAnswers.value = [];
    exerciceData.idRegleacquise.value = "";
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Empêchez la navigation arrière en ne faisant rien
        return false;
      },
      child: Scaffold(
        backgroundColor: white,
        body: Container(
          width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/backExercice.PNG"),
                  fit: BoxFit.fill)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Image(
                      image: AssetImage("assets/images/logo1.png"),
                      width: 100,
                      height: 100,
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () async {
                          alertQuitter("Vérification",
                              "Etes-vous sur de quiter ?", context);
                        },
                        icon: Icon(
                          Icons.close,
                          color: white,
                          size: 60,
                        )),
                    SizedBox(
                      width: 30,
                    )
                  ],
                ),
                Align(
                  child: SizedBox(
                    height: 100,
                    width: Get.width / 2.2,
                    child: GridView.builder(
                      padding: EdgeInsets.only(top: 0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: exerciceData.listRegle.value.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        print("acquise: ${exerciceData.regleAcquises}");
                        if (exerciceData.regleAcquises.any((acquise) =>
                            acquise != null &&
                            acquise["idRegle"]
                                is String && // Vérifiez que l'identifiant est une chaîne
                            acquise["idRegle"] ==
                                exerciceData.listRegle[index]["idRegle"]))
                          return Image(
                              image: AssetImage("assets/images/medalsJ.PNG"));
                        else
                          return Image(
                              image: AssetImage("assets/images/medalsG.PNG"));
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Obx(
                  () => GFProgressBar(
                    alignment: MainAxisAlignment.center,
                    percentage: exerciceData.percent.value /
                        exerciceData.taillePhrase.value,
                    width: Get.width * 0.5,
                    lineHeight: 30,
                    radius: 100,
                    backgroundColor: white,
                    progressBarColor: Color.fromARGB(255, 105, 143, 227),
                    trailing: Row(
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        InkWell(
                          onTap: () async {
                            await statistiquesData
                                .getAllRule(exerciceData.nivAct.value);
                            await statistiquesData
                                .getRegleAcquis(exerciceData.nivAct.value);

                            Get.to(() => Statistiques());
                          },
                          child: Image(
                            image: AssetImage("assets/icons/stat1.png"),
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 70),
                  child: addText("Consigne", black, true, 25, false, "schyler"),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Wrap(
                    children: words.map((word) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return IgnorePointer(
                            ignoring: exerciceData.isUnderlined.value,
                            child: InkWell(
                              onTap: () {
                                setState(
                                  () {
                                    
                                    print(enable);
                                    exerciceData.isUnderlined.value = true;
                                    print(word);
                                    print("current phrase index");
                                    print(
                                        exerciceData.currentIndexPhrase.value);
                                    exerciceData.validateResultUser(
                                        word,
                                        exerciceData.listPhrase.value[
                                            exerciceData
                                                .currentIndexPhrase.value],
                                        exerciceData.listRegle.value[
                                            exerciceData
                                                .currentIndexRegle.value]);
                                                regCrucial.value = false;
                                    enable.value = true;
                                    print("liste phrase");
                                    print(exerciceData.listPhrase.value);
                                    correctAns(words);
                                  },
                                );
                              },
                              child: Obx(
                                () => Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text(
                                    word,
                                    style: TextStyle(
                                      color: black,
                                      fontSize: 20,
                                      decoration: (exerciceData
                                                      .motIncorrect.value ==
                                                  word &&
                                              exerciceData.isUnderlined.value)
                                          ? TextDecoration.underline
                                          : TextDecoration.none,
                                      decorationThickness: 3,
                                      decorationStyle: TextDecorationStyle.wavy,
                                      decorationColor: red,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: !enable.value,
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              exerciceData.validateResultUser(
                                  "",
                                  exerciceData.listPhrase.value[
                                      exerciceData.currentIndexPhrase.value],
                                  exerciceData.listRegle.value[
                                      exerciceData.currentIndexRegle.value]);
                              print("current phrase index");
                              print(exerciceData.currentIndexPhrase.value);
                              regCrucial.value = false;
                              enable.value = true;
                            },
                            style: addButtonStyle(20, kprimaryB),
                            child: addText("Il n'y a pas de faute", white, true,
                                20, false, ""),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                      visible: regCrucial.value,
                      child: Column(children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 60, left: 10),
                              child: Image(
                                image: AssetImage("assets/images/penguin2.PNG"),
                                width: 80,
                                height: 80,
                              ),
                            ),
                            Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Image(
                                    image:
                                        AssetImage("assets/icons/bulleB.png"),
                                    width: 250),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: addText("CONCENTRE-TOI ! ", white,
                                          true, 20, false, "schyler"),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    addText("QUESTION MAJEURE", white, true, 16,
                                        false, "schyler")
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ])),
                ),
                Obx(
                  () => Visibility(
                    visible: enable.value,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 60, left: 10),
                              child: Image(
                                image: AssetImage("assets/images/penguin2.PNG"),
                                width: 80,
                                height: 80,
                              ),
                            ),
                            Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Image(
                                    image: exerciceData.etatResponseUser.value
                                        ? AssetImage("assets/icons/bulleG.png")
                                        : AssetImage("assets/icons/bulleO.png"),
                                    width: 250),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: addText(
                                          exerciceData.etatResponseUser.value
                                              ? "Bravo"
                                              : "Mauvais Réponse",
                                          white,
                                          true,
                                          20,
                                          false,
                                          "schyler"),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    addText(exerciceData.erreur.value, white,
                                        true, 16, false, "schyler")
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            padding: EdgeInsets.only(left: 10, top: 5),
                            alignment: Alignment.topLeft,
                            width: Get.width / 1.5,
                            decoration: BoxDecoration(
                                border: Border.all(color: black, width: 2),
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                addText("La phrase Correcte :", kprimaryG2,
                                    true, 16, false, "schyler"),
                                SizedBox(
                                  height: 5,
                                ),
                                addText(phraseCorrect.value, black, false, 16,
                                    false, ""),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    addText("La régle :", black, true, 16,
                                        false, "schyler"),
                                    IconButton(
                                        onPressed: () {
                                          showSheet();
                                        },
                                        icon: Icon(
                                          Icons.menu_book_outlined,
                                          size: 30,
                                        ))
                                  ],
                                ),
                                addText(
                                    exerciceData.listRegle.value[exerciceData
                                        .currentIndexRegle
                                        .value]["Regle"]["titre"],
                                    black,
                                    false,
                                    16,
                                    false,
                                    ""),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Obx(
                  () => Visibility(
                    visible: enable.value,
                    child: Container(
                      padding: EdgeInsets.only(right: 10),
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () async {
                          exerciceData.listPhrase.length > 0
                              ? {
                                      nextPhrase(),

                                  print(regCrucial.value),
                                  if (exerciceData.successiveCorrectAnswers.any(
                                     (element) {
                                      print(exerciceData.listPhrase.value[
                                                  exerciceData.currentIndexPhrase
                                                      .value]["idRegle"]);
                                        return  exerciceData.listPhrase.value[
                                                  exerciceData.currentIndexPhrase
                                                      .value]["idRegle"] ==
                                              element["idRegle"] &&
                                          element["succ"] == 1;}))
                                      
                                         
                                    {
                                      regCrucial.value = true,
                                      
                                    }
                                  else
                                    {
                                      regCrucial.value = false,
                                    }
                                }
                              : {
                                  await exerciceData.updatePercent(),
                                  await homePage.afficheData(),
                                  print(exerciceData.percentNiv),
                                  Get.back()
                                };
                          exerciceData.isUnderlined.value = false;
                          print("current phrase index");
                          print(exerciceData.currentIndexPhrase.value);
                          print("current regle index");
                          print(exerciceData.currentIndexRegle.value);
                          print("success rule");
                          print(exerciceData.successiveCorrectAnswers.value);

                          // Fermer la feuille coulissante lorsque vous appuyez sur le bouton

                          enable.value = false;
                        },
                        child: addText("Suivant ", black, true, 20, false, ""),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void nextPhrase() {
    if (exerciceData.currentIndexPhrase.value <
        exerciceData.listPhrase.length - 1) {
      exerciceData.currentIndexPhrase.value++;
      words = exerciceData.listPhrase
          .value[exerciceData.currentIndexPhrase.value]["phrase"]["textPhrase"]
          .split(' ');
      exerciceData.checkAiSpelling(
          exerciceData.listPhrase.value[exerciceData.currentIndexPhrase.value]
              ["phrase"]["textPhrase"]);
      exerciceData.etatResponseUser.value = false;
      exerciceData.getIndexRegle(exerciceData
          .listPhrase.value[exerciceData.currentIndexPhrase.value]["idRegle"]);
      // Divisez la nouvelle phrase en mots
    } else {
      exerciceData.currentIndexPhrase.value = 0;
      print(exerciceData.currentIndexPhrase.value);
      words = exerciceData.listPhrase
          .value[exerciceData.currentIndexPhrase.value]["phrase"]["textPhrase"]
          .split(' ');
      print(words);
      exerciceData.checkAiSpelling(
          exerciceData.listPhrase.value[exerciceData.currentIndexPhrase.value]
              ["phrase"]["textPhrase"]);
      exerciceData.etatResponseUser.value = false;
      exerciceData.getIndexRegle(exerciceData
          .listPhrase.value[exerciceData.currentIndexPhrase.value]["idRegle"]);
    }

    setState(
        () {}); // Rafraîchissez l'interface utilisateur pour afficher la nouvelle phrase
  }

  Future<void> showSheet() async {
    await showSlidingBottomSheet(
      resizeToAvoidBottomInset: true,
      context,
      builder: (context) => SlidingSheetDialog(
        elevation: 8,
        cornerRadius: 16,
        isDismissable: false,
        builder: (context, state) => Material(
          child: Container(
            height: 600,
            width: Get.width,
            decoration: addBoxDecoration(Color.fromARGB(255, 235, 234, 234)),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, top: 10),
                  child: Column(children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: addText("Cour", black, true, 25, false, "schyler"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: addText(
                          exerciceData.listRegle
                                  .value[exerciceData.currentIndexRegle.value]
                              ["Regle"]["cour"],
                          black,
                          false,
                          20,
                          false,
                          "schyler"),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: addText(
                              "Compris", black, true, 20, false, "schyler")),
                    )
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  alertQuitter(String titre, String contenu, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          titre,
          style: TextStyle(fontSize: 30),
        ),
        content: Text(contenu, style: TextStyle(fontSize: 20)),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (exerciceData.regleAcquises.length > 0)
                exerciceData.percent.value = 0;
              await exerciceData.updatePercent();
              await homePage.afficheData();
              Get.back();
              Get.back();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  correctAns(List<String> words) {
    print(exerciceData.motIncorrect.value);
    phraseCorrect.value = "";
    for (String word in words) {
      if (exerciceData.motIncorrect.value.isEmpty) {
        phraseCorrect.value = "Phrase correct";
      } else if (word == exerciceData.motIncorrect.value) {
        word = exerciceData.solution.value;
        phraseCorrect.value += word + " ";
      } else
        phraseCorrect.value += word + " ";
    }
    print(phraseCorrect.value);
  }
}
