import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tests/Constants/constants.dart';
import 'package:http/http.dart' as http;

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
               setState(() {
                  detectImage();
               });
              },
              child: Text("Detect ")),

              SizedBox(height: 20,),
              addText("Bonjour je suis alice",
               black,
              true,
              30,
              false,
              "cursif")

        ],
      ),
    ));
  }

  Future<void> detectImage() async {
   final apiKey = 'e31b9d4d0e67487abdd2fdc06be16d61';
  final endpoint =
      'https://api.clarifai.com/v2/users/clarifai/apps/main/models/general-image-recognition/versions/aa7f35c01e0642fda5cf400f543e7c40/outputs';

  final headers = {
    'Authorization': 'Key $apiKey',
    'Content-Type': 'application/json',
  };

  final body = {
    "inputs": [
      {
        "data": {
          "image": {
            "url": "https://th-thumbnailer.cdn-si-edu.com/4Nq8HbTKgX6djk07DqHqRsRuFq0=/1000x750/filters:no_upscale()/https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/d5/24/d5243019-e0fc-4b3c-8cdb-48e22f38bff2/istock-183380744.jpg"
          }
        }
      }
    ]
  };

  final response = await http.post(
    Uri.parse(endpoint),
    headers: headers,
    body: json.encode(body),
  );
  if (response.statusCode == 200) {
    // La requête a réussi, vous pouvez traiter les résultats ici
    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData['outputs'][0]['data']["concepts"][0]["name"]);
    translateText();

    // Traitez les données de réponse
  } else {
    // La requête a échoué, gérer les erreurs ici
    print('Erreur : ${response.statusCode}');
  }
  }

  Future<void> translateText() async {
   final url = Uri.parse('https://microsoft-translator-text.p.rapidapi.com/translate?to%5B0%5D=fr&api-version=3.0&from=en&profanityAction=NoAction&textType=plain');
  final headers = {
    'Content-Type': 'application/json',
    'X-Rapidapi-Key': '91c5edfb14mshac8f1bfaba68c1fp1db9e5jsnd3ed89f49f08',
    'X-Rapidapi-Host': 'microsoft-translator-text.p.rapidapi.com',
  };

  final requestBody = [
    {
      'Text': 'banana',

    },
    {
      'Text': 'banana',

    }
  ];

  final response = await http.post(
    url,
    headers: headers,
    body: jsonEncode(requestBody),
  );

  if (response.statusCode == 200) {
    // Traitement de la réponse
    final responseData = jsonDecode(response.body);
    print('Réponse : $responseData');
  } else {
    // Gestion des erreurs
    print('Erreur : ${response.statusCode}');
  }
}

}
