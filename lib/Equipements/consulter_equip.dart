import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn/Equipements/ajouter.dart';
import 'package:learn/Equipements/gestion_inv.dart';
import 'package:learn/Equipements/modifier.dart';
import 'package:learn/Equipements/recherche_id.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class Consulter extends StatefulWidget {
  final docsid;
  const Consulter({Key? key, this.docsid}) : super(key: key);
  @override
  _ConsulterState createState() => _ConsulterState();
}

class _ConsulterState extends State<Consulter> {

  CollectionReference equipref =
      FirebaseFirestore.instance.collection("bd_equip");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
         leading:  IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return const GestionInv ();
                }
                ));
               }),
        title: const Text("Liste des Mahines",
            style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
              icon: const Icon(Icons.add_circle_rounded),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const FormInv();
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
            future: equipref.get(),
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
                  String? designation = data['Désignation'];
                  dynamic id = data['ID'];

                }
                return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, i) {
                      return Card(
                        child:
                            ListTile(
                              leading: SizedBox(
                                height: 50,
                                width: 50,
                                 child: PrettyQr(
                                    typeNumber: 3,
                                    size: 50,
                                    errorCorrectLevel: QrErrorCorrectLevel.M,
                                    roundEdges: true,
                                    data:list[i]['ID'].toString(),
                                              
                                  ),
                               ),
                              splashColor: Colors.grey,
                              title: Text("ID : ${list[i]['ID'].toString()}",
                                           style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Désignation : ${list[i]["Désignation"]}",
                                        style: const TextStyle(fontWeight: FontWeight.bold)),
                                  Text(
                                      "Marque : ${list[i]["Marque"]}",
                                       style: const TextStyle(fontWeight: FontWeight.bold)),
                                  Text(
                                      "Unité : ${list[i]["Unité"]}",
                                       style: const TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                              trailing: SizedBox(
                                width: 100,
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context) {
                                          return Edit(
                                              BD: snapshot.data!.docs[i],
                                              docsid: snapshot.data!.docs[i].id);
                                        }));
                                      },
                                      icon: const Icon(Icons.edit,
                                          color: Colors.blueGrey),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        equipref
                                            .doc(snapshot.data!.docs[i].id)
                                            .delete();
                                        setState(() {
                                          equipref.get();
                                        });
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return  AlertDialog(
                                                actions: [
                                                    TextButton(onPressed: () {
                                                      Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                      builder: (context) {
                                                      return const Consulter();},),);
                                                    } ,
                                                    child: const Text("OK")),
                                                    TextButton(onPressed: (){} , child: const Text("Annuler")),
                                                  ],
                                                title: const Text("Succés"),
                                                content: const Text("Machine Supprimée"),
                                              );
                                            });
                                      },
                                      icon: const Icon(Icons.delete,
                                          color: Colors.blueGrey),
                                    ),
                                  ],
                                ),
                              ),
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
