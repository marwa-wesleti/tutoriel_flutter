import 'package:flutter/material.dart';
enum Jour {
  Lundi,
  Mardi,
  Mercredi,
  Jeudi,
  Vendredi,
  Samedi,
}

class table extends StatefulWidget {
  @override
  _tableState createState() => _tableState();
}

class _tableState extends State<table> {
  List<Map<String, dynamic>> emplois = [
    {'Jour': 'Lundi', 'Horaire': '8:00', 'Travail': 'Travail 1'},
    {'Jour': 'Lundi', 'Horaire': '9:00', 'Travail': 'Travail 2'},
    {'Jour': 'Mardi', 'Horaire': '10:00', 'Travail': 'Travail 3'},
    {'Jour': 'Mardi', 'Horaire': '11:00', 'Travail': 'Travail 4'},
  ];

List<String> Horaire = [
  "8_9",
  "9_10",
  "10_11",
  "11_12",
  "12_13",
  "13_14",
  "14_15",
  "15_16",
  "16_17",
  "17_18"
];
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns:addColumns(),
      rows: List.generate(Jour.values.length, (index) {
        return DataRow(
          cells: List.generate(emplois[index].length, (cellIndex) {
            if (cellIndex == 0) {
              return DataCell(Text(emplois[index]['Jour']));
            } else {
              final cellValue = emplois[index][emplois[index].keys.toList()[cellIndex]];
              return DataCell(HoverDeleteCell(
                value: cellValue,
                onDelete: () {
                  // Remove the value only
                  setState(() {
                    emplois[index][emplois[index].keys.toList()[cellIndex]] = '';
                  });
                },
              ));
            }
          }),
        );
      }),
    );
  }
   List<DataColumn> addColumns() {
    final List<String> columnHeaders = ['Jour/Horaire'];
    for (String time in Horaire) {
      columnHeaders.add(time);
    }
    columnHeaders.add('Action');
    return columnHeaders
        .map((header) => DataColumn(label: Text(header)))
        .toList();
  }
}

class HoverDeleteCell extends StatefulWidget {
  final String value;
  final VoidCallback onDelete;

  HoverDeleteCell({required this.value, required this.onDelete});

  @override
  _HoverDeleteCellState createState() => _HoverDeleteCellState();
}

class _HoverDeleteCellState extends State<HoverDeleteCell> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: InkWell(
        onTap: widget.onDelete,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: isHovered
              ? Row(
                  children: [
                    Text(widget.value),
                    SizedBox(width: 8),
                    Icon(Icons.delete, color: Colors.red),
                  ],
                )
              : Text(widget.value),
        ),
      ),
    );
  }
  
}