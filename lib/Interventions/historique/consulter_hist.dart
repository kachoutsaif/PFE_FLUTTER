import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn/Equipements/recherche_id.dart';
import 'package:learn/Interventions/gestionintervention.dart';
import 'package:learn/Interventions/historique/ajout_his.dart';

class ConsulterHist extends StatefulWidget {
  final docsid;
  const ConsulterHist({Key? key, this.docsid}) : super(key: key);
  @override
  _ConsulterHistState createState() => _ConsulterHistState();
}

class _ConsulterHistState extends State<ConsulterHist> {

  CollectionReference histref =
      FirebaseFirestore.instance.collection("Historique");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const GestionIntervention ();
                }));
              }),
        title: const Text("Historique Interventions",
            style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
              icon: const Icon(Icons.add_circle_rounded),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const Ajouthistorique();
                }));
              }),
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: (){
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const Recherche();
                }));
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
            future: histref.get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Map<String, dynamic>>  list = [];
                int i = 0;
                for (QueryDocumentSnapshot<Object?> documentSnapshot
                    in snapshot.data!.docs) {
                  // print(documentSnapshot.data().);
                  Map<String, dynamic> data =
                      documentSnapshot.data() as Map<String, dynamic>;
                      list.add(data);
                }
                return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, i) {
                      return Card(
                        child: ListTile(
                          splashColor: Colors.grey,
                          title: Text("MachineID : ${list[i]['MachineID'].toString()}",
                                       style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Date : ${list[i]["Date"]}",
                                    style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text(
                                  "Interventions : ${list[i]["Interventions"]}",
                                   style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text(
                                  "Type : ${list[i]["Type"]}",
                                   style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          trailing: const SizedBox(width: 100),
                        ),
                      );
                    });
              }
              if (snapshot.hasError) {
                // showDialog(
                //     context: context,
                //     builder: (context) {
                return const AlertDialog(
                  title: Text("Error"),
                  content: Text(""),
                );
                // });
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return const Text("verifier");
            }),
      ),
    );
  }
}

List<Equipement> equipementFromJson(List str) =>
    List<Equipement>.from(str.map((x) => Equipement.fromJson(x)));

String equipementToJson(List<Equipement> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Equipement {
  Equipement({
    this.dsignation,
    this.marque,
    this.unit,
  });

  final String? dsignation;
  final String? marque;
  final String? unit;

  factory Equipement.fromJson(Map<String, dynamic> json) => Equipement(
        dsignation: json["Désignation"],
        marque: json["Marque"],
        unit: json["Unité"],
      );

  Map<String, dynamic> toJson() => {
        "Désignation": dsignation,
        "Marque": marque,
        "Unité": unit,
      };
}
