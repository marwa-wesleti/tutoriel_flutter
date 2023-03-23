
import 'package:flutter/material.dart';

class MyDataTable extends StatefulWidget {
  static final roteName = "exemple";
  @override
  _MyDataTableState createState() => _MyDataTableState();
}

class _MyDataTableState extends State<MyDataTable> {
  List<DataRow> rows = [
   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My DataTable'),
      ),
      body: SingleChildScrollView(
        child: DataTable(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 243, 242, 242)
          ),
          headingRowColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            
              return Color.fromARGB(255, 1, 27, 98);
             // Use the default value.
          }),
          headingTextStyle: TextStyle(color: Colors.white),
          border: TableBorder.all(color: Color.fromARGB(255, 255, 255, 255),width: 2.0,style: BorderStyle.solid),
          columns: [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Email')),
            DataColumn(label: Text('Phone')),
            DataColumn(label: Text('Matière enseignée')),
            DataColumn(label: Text('Classe(s) enseignée(s)')),

          ],
          rows: rows,
          
        ),
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Ajouter une nouvelle ligne au DataTable
          setState(() {
            rows.add(
              DataRow(cells: [
                DataCell(Text('${rows.length + 1}')),
                DataCell(Text('New')),
                DataCell(Text('Row')),
                DataCell(Text('New')),
                DataCell(Text('Row')),
              ]),
            );
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
