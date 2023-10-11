import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn/Intervenants/ajout_int.dart';
import 'package:learn/Intervenants/fichemetier.dart';
import 'package:learn/Intervenants/inv_recherche.dart';
import 'package:learn/Intervenants/modif_interv.dart';

class ConsulterIntervn extends StatefulWidget {
  final docsid;
  const ConsulterIntervn({Key? key, this.docsid}) : super(key: key);
  @override
  _ConsulterIntervnState createState() => _ConsulterIntervnState();
}

class _ConsulterIntervnState extends State<ConsulterIntervn> {

  CollectionReference intervref =
      FirebaseFirestore.instance.collection("Intervention");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text("Les Interventions",
            style: TextStyle(color: Colors.white)),
        leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const FicheMetie();
                }));
              }),
        actions: [
          IconButton(
              icon: const Icon(Icons.add_circle_rounded),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const AjoutInterv();
                }));
              }),
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: (){
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const InterRecherche();
                }));
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
            future: intervref.get(),
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
                          title: Text("Matricule : ${list[i]['Matricule'].toString()}",
                                      style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Date : ${list[i]["Date"]?.toDate()}",
                                  style: const TextStyle(fontWeight: FontWeight.bold),),
                              Text(
                                  "Interventions : ${list[i]["Interventions"]}",
                                   style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text(
                                  "Unité : ${list[i]["Unité"]}",
                                   style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text(
                                  "Type : ${list[i]["Type"]}",
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
                                      return ModifierInterv(
                                          BD: snapshot.data!.docs[i],
                                          docsid: snapshot.data!.docs[i].id);
                                    }));
                                  },
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blueGrey),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    intervref
                                        .doc(snapshot.data!.docs[i].id)
                                        .delete();
                                    setState(() {
                                      intervref.get();
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
                                                  return const ConsulterIntervn();},),);
                                                } ,
                                                child: const Text("OK")),
                                                TextButton(onPressed: (){} , child: const Text("Annuler")),
                                              ],
                                            title: const Text("Succés"),
                                            content: const Text("Intervention Supprimée"),
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

