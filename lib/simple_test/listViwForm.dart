import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class listViewForm extends StatefulWidget {
  const listViewForm({super.key});

  @override
  State<listViewForm> createState() => _listViewFormState();
}

class _listViewFormState extends State<listViewForm> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _matiereController = TextEditingController();
  final TextEditingController _classeController = TextEditingController();
  final List<Map<String, dynamic>> _notes = [];
  final TextEditingController _eleveController = TextEditingController();
  final TextEditingController _noteOraleController = TextEditingController();
  final TextEditingController _noteEcritController = TextEditingController();



  void _ajouterNote() {
    setState(() {
      _notes.add({
        'eleve': _eleveController.text,
        'noteOrale': double.parse(_noteOraleController.text),
        'noteEcrit': double.parse(_noteEcritController.text),

      });
      _eleveController.clear();
      _noteOraleController.clear();
      _noteEcritController.clear();

    });
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter des notes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _matiereController,
                decoration: InputDecoration(labelText: 'Matière'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez saisir la matière';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _classeController,
                decoration: InputDecoration(labelText: 'Classe'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez saisir la classe';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text('Notes'),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: _notes.length,
                  itemBuilder: (context, index) {
                    return Row(
                children: [
                  Expanded(
                    child: Text(""+
                     _notes[index]['eleve']
                    ),
                  ),
                  SizedBox(width: 10),
                   Expanded(
                     child: Text(_notes[index]['noteOrale'].toString()
                    ),
                  ),
                   SizedBox(width: 10),
                   Expanded(
                     child: Text(
                     _notes[index]['noteEcrit'].toString()
                    ),
                  ),
                ]
              );

                    
                  },
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _eleveController,
                      decoration: InputDecoration(labelText: 'Élève'),
                    ),
                  ),
                  SizedBox(width: 10),
                   Expanded(
                    child: TextFormField(
                      controller: _noteOraleController,
                      decoration: InputDecoration(labelText: 'noteOrale'),
                    ),
                  ),
                   SizedBox(width: 10),
                   Expanded(
                    child: TextFormField(
                      controller: _noteEcritController,
                      decoration: InputDecoration(labelText: 'noteEcrit'),
                    ),
                  ),
                ]
              ),
               SizedBox(height: 10),
               ElevatedButton(
                onPressed: () => _ajouterNote(),
                 child: Text("ajouter note"))
            ]
          )
        )
      )
    );
  }
  
}