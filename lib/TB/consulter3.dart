import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:learn/TB/showgraphe.dart';

class _InterventionPrevData {
  final String technicien;
  final int count;

  _InterventionPrevData(this.technicien, this.count);
}

class InterventionPrevData extends StatefulWidget {
  @override
  _InterventionPrevDataState createState() => _InterventionPrevDataState();
}

class _InterventionPrevDataState extends State<InterventionPrevData> {
  List<_InterventionPrevData> _interventionDataList = [];

    final List<charts.Color> _colorPalette = [
    charts.Color.fromHex(code: '#8C924F'), // Rouge
    charts.Color.fromHex(code: '#C5D6A1'), // violet
    charts.Color.fromHex(code: '#0000FF'), // Bleu
    charts.Color.fromHex(code: '#FFFF00'), // Jaune
    charts.Color.fromHex(code: '#FFA500'), // Orange
    charts.Color.fromHex(code: '#800080'), // Violet
  ];

  @override
  void initState() {
    super.initState();
    _getInterventionData();
  }

  void _getInterventionData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Intervention').get();
    Map<String, int> technicienCountMap = {};
    querySnapshot.docs.forEach((doc) {
      String type = doc['Type'];
      String technicien = doc['Nom'];
      if (type == 'preventive') {
        if (technicienCountMap.containsKey(technicien)) {
          technicienCountMap[technicien] = technicienCountMap[technicien]! + 1;
        } else {
          technicienCountMap[technicien] = 1;
        }
      }
    });
    List<_InterventionPrevData> interventionDataList = technicienCountMap.entries
        .map((entry) => _InterventionPrevData(entry.key, entry.value))
        .toList();
    setState(() {
      _interventionDataList = interventionDataList;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<_InterventionPrevData, String>> seriesList = [
      charts.Series(
        id: 'Interventions préventives par technicien',
        data: _interventionDataList,
        domainFn: (data, _) => data.technicien,
        measureFn: (data, _) => data.count,
        labelAccessorFn: (data, _) => '${data.technicien}: ${data.count}',
       colorFn: (data, index) => _colorPalette[index! % _colorPalette.length],
      ),
    ];

     Widget chartWidget = charts.BarChart(
      seriesList,
      animate: true,
      behaviors: [
            charts.ChartTitle('Technicien',
             behaviorPosition: charts.BehaviorPosition.bottom,
             titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
            charts.ChartTitle('Intervention Preventive',
              behaviorPosition: charts.BehaviorPosition.start,
              titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
                ],
      barRendererDecorator: charts.BarLabelDecorator<String>(
        insideLabelStyleSpec: const charts.TextStyleSpec(
          fontSize: 15,
          color: charts.Color.white,
        ),
        outsideLabelStyleSpec: charts.TextStyleSpec(
          fontSize: 10,
          color: charts.MaterialPalette.black.lighter,
        ),
      ),
      domainAxis: const charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          labelRotation: 0,
          labelAnchor: charts.TickLabelAnchor.after,
        ),
      ),
      primaryMeasureAxis: const charts.NumericAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          labelStyle: charts.TextStyleSpec(
            fontSize: 12, // ajuster la taille des étiquettes des axes Y
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Interventions préventives par technicien'),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const TabBord();
                }));
              }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SizedBox(
            height: 500,
            child: Card(
              elevation: 10,
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: chartWidget,
              ),
            ),
          ),
        ),
      )
    );
  }
}
