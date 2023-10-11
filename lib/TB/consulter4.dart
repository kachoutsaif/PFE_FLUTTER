import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:learn/TB/showgraphe.dart';

class _InterventionData {
  final int year;
  final int month;
  final int count;

  _InterventionData(this.year, this.month, this.count);
}

class InterventionAnalyticsSelec extends StatefulWidget {
  @override
  _InterventionAnalyticsState createState() => _InterventionAnalyticsState();
}

class _InterventionAnalyticsState extends State<InterventionAnalyticsSelec> {
  List<_InterventionData> _interventionDataList = [];

  final List<charts.Color> _colorPalette = [
    charts.Color.fromHex(code: '#BF429A'), // violet1
    charts.Color.fromHex(code: '#AE50CE'), // violet2
    charts.Color.fromHex(code: '#6650B2'), // violet3
    charts.Color.fromHex(code: '#0D47A1'), // Jaune
    charts.Color.fromHex(code: '#FFA500'), // Orange
    charts.Color.fromHex(code: '#800080'), // Violet
  ];

  @override
  void initState() {
    super.initState();
    _getInterventionDataList();
  }

  void _getInterventionDataList() async {
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('Intervention').get();

  Map<String, Map<String, int>> interventionsMap = {};

  querySnapshot.docs.forEach((doc) {
    Timestamp timestamp = doc['Date'];
    DateTime date = timestamp.toDate(); // Convertir Timestamp en DateTime
    int year = date.year;
    int month = date.month;

    String key = '$year-$month';

    if (interventionsMap.containsKey(key)) {
      interventionsMap[key]!['count'] = interventionsMap[key]!['count']! + 1;
    } else {
      interventionsMap[key] = {'year': year, 'month': month, 'count': 1};
    }
  });

  List<_InterventionData> interventionDataList =
      interventionsMap.entries.map((entry) {
    Map<String, int> dataMap = entry.value;
    return _InterventionData(dataMap['year']!, dataMap['month']!, dataMap['count']!);
  }).toList();

  setState(() {
    _interventionDataList = interventionDataList;
  });
}

  @override
  Widget build(BuildContext context) {
    List<charts.Series<_InterventionData, String>> seriesList = [
      charts.Series(
        id: 'Interventions',
        data: _interventionDataList,
        domainFn: (data, _) => '${data.year}-${data.month}',
        measureFn: (data, _) => data.count,
        labelAccessorFn: (data, _) => '${data.count} interventions',
       colorFn: (data, index) => _colorPalette[index! % _colorPalette.length],
      ),
    ];
     Widget chartWidget = charts.BarChart(
                seriesList,
                animate: true,
                barGroupingType: charts.BarGroupingType.grouped,
                vertical: true,
                behaviors: [
                  charts.ChartTitle('Mois et Année',
                      behaviorPosition: charts.BehaviorPosition.bottom,
                      titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
                  charts.ChartTitle('Nombre d\'interventions',
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
        title: const Text('Répartition des interventions par mois et par année'),
        backgroundColor: Colors.blueGrey,
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
    