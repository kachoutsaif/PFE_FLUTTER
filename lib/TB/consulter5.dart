import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class _InterventionData {
  final String unit;
  final DateTime date;
  final String technician;
  final int correctiveCount;

  _InterventionData(
      this.unit, this.date, this.technician, this.correctiveCount);
}

class CorrectiveInterventionAnalytics extends StatefulWidget {
  @override
  _CorrectiveInterventionAnalyticsState createState() =>
      _CorrectiveInterventionAnalyticsState();
}

class _CorrectiveInterventionAnalyticsState
    extends State<CorrectiveInterventionAnalytics> {
  List<_InterventionData> _interventionDataList = [];

  final List<charts.Color> _colorPalette = [
    charts.Color.fromHex(code: '#FC6A03'),
    charts.Color.fromHex(code: '#3E8EDE'), // violet
    charts.Color.fromHex(code: '#0000FF'), // Bleu
    charts.Color.fromHex(code: '#FFFF00'), // Jaune
    charts.Color.fromHex(code: '#FFA500'), // Orange
    charts.Color.fromHex(code: '#800080'), // Violet
  ];

  @override
  void initState() {
    super.initState();
    _getCorrectiveInterventionData();
  }

  void _getCorrectiveInterventionData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Intervention')
        .where('Type', isEqualTo: 'corrective')
        .get();

    List<_InterventionData> interventionDataList = [];

    querySnapshot.docs.forEach((doc) {
      String unit = doc['Unité'];
      DateTime date = doc['Date'].toDate();
      String technician = doc['Nom'];
      int correctiveCount = 1; // Assuming each document represents one corrective intervention

      _InterventionData interventionData =
          _InterventionData(unit, date, technician, correctiveCount);
      interventionDataList.add(interventionData);
    });

    setState(() {
      _interventionDataList = interventionDataList;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<_InterventionData, String>> seriesList = [
      charts.Series(
        id: 'Interventions correctives',
        data: _interventionDataList,
        domainFn: (data, _) =>
            '${data.unit}\n${data.date.day}/${data.date.month}/${data.date.year}\n${data.technician}',
        measureFn: (data, _) => data.correctiveCount,
        labelAccessorFn: (data, _) =>
            '${data.unit}\n${data.date.day}/${data.date.month}/${data.date.year}\n${data.technician}: ${data.correctiveCount.toString()}',
        colorFn: (data, index) => _colorPalette[index! % _colorPalette.length],
      ),
    ];

    Widget chartWidget = charts.BarChart(
      seriesList,
      animate: true,
      behaviors: [
        charts.ChartTitle('Unité, Date, Technicien',
            behaviorPosition: charts.BehaviorPosition.bottom,
            titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
        charts.ChartTitle('Interventions Correctives',
            behaviorPosition: charts.BehaviorPosition.start,
            titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
      ],
      barRendererDecorator: charts.BarLabelDecorator<String>(
        insideLabelStyleSpec: const charts.TextStyleSpec(
         
        fontSize: 12,
          color: charts.Color.white,
        ),
        outsideLabelStyleSpec: charts.TextStyleSpec(
          fontSize: 12,
          color: charts.MaterialPalette.black.lighter,
        ),
      ),
      domainAxis: const charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          labelRotation: 0,
          labelAnchor: charts.TickLabelAnchor.centered,
          labelJustification: charts.TickLabelJustification.inside,
        ),
      ),
      primaryMeasureAxis: const charts.NumericAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          labelStyle: charts.TextStyleSpec(
            fontSize: 12,
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Interventions correctives'),
        backgroundColor: Colors.blueGrey,
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
      ),
    );
  }
}
