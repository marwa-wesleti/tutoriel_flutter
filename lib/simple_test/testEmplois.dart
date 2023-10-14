import 'package:flutter/material.dart';

class TimeTablePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timetable'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(child: Text('Heures')),
                Expanded(child: Text('Lundi')),
                Expanded(child: Text('Mardi')),
                Expanded(child: Text('Mercredi')),
                Expanded(child: Text('Jeudi')),
                Expanded(child: Text('Vendredi')),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: <Widget>[
                      Expanded(
                        child: Text('${index + 8}h00 - ${index + 9}h00'),
                      ),
                      Expanded(
                        child: Text('Mathématiques - Salle 101'),
                      ),
                      Expanded(
                        child: Text('Français - Salle 102'),
                      ),
                      Expanded(
                        child: Text('EPS - Salle 103'),
                      ),
                      Expanded(
                        child: Text('Histoire - Salle 104'),
                      ),
                      Expanded(
                        child: Text('SVT - Salle 105'),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}