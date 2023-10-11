import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:learn/Menu/menu_page.dart';
import 'package:learn/TB/showgraphe.dart';

class _InterventionData {
  final String unite;
  final int count;
  _InterventionData(this.unite, this.count);
}
class InterventionParUnite extends StatefulWidget {
  @override
  _InterventionParUniteState createState() => _InterventionParUniteState();
}
class _InterventionParUniteState extends State<InterventionParUnite> {
  List<_InterventionData> _interventionDataList = [];

  final List<charts.Color> _colorPalette = [
    charts.Color.fromHex(code: '#9F4D28'), // vert
    charts.Color.fromHex(code: '#D2915B'), // blue ciel
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
    Map<String, int> interventionCountMap = {};
    querySnapshot.docs.forEach((doc) {
      String unite = doc['Unité'];
      if (interventionCountMap.containsKey(unite)) {
        interventionCountMap[unite] = interventionCountMap[unite]! + 1;
      } else {
        interventionCountMap[unite] = 1;
      }
    });
    List<_InterventionData> interventionDataList = interventionCountMap.entries
        .map((entry) => _InterventionData(entry.key, entry.value))
        .toList();
    setState(() {
      _interventionDataList = interventionDataList;
    });
  }
  @override
  Widget build (BuildContext context) {
    List<charts.Series<_InterventionData , String>> seriesList = [
       charts.Series(
          id: 'unité',
          data: _interventionDataList,
          domainFn: (data, _) => data.unite,
          measureFn: (data, _) => data.count,
          labelAccessorFn: (data, _) => '${data.unite}: ${data.count}',
          colorFn: (data, index) => _colorPalette[index! % _colorPalette.length],
        ),
    ];
  
 Widget chartWidget = charts.BarChart(
      seriesList,
      animate: true,
      behaviors: [
            charts.ChartTitle('Unité',
             behaviorPosition: charts.BehaviorPosition.bottom,
             titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
            charts.ChartTitle('Intervention Totale',
              behaviorPosition: charts.BehaviorPosition.start,
              titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
                ],
       barRendererDecorator: charts.BarLabelDecorator<String>(
        insideLabelStyleSpec: const charts.TextStyleSpec(
          fontSize: 15,
          color: charts.Color.white,
        ),
        outsideLabelStyleSpec: charts.TextStyleSpec(
          fontSize: 15,
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
        title: const Text('Intervention Totale par Unite'),
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
      ),
    );
  }
}