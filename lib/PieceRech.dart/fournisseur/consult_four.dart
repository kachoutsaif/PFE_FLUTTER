import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn/Equipements/modifier.dart';
import 'package:learn/PieceRech.dart/Article.dart';
import 'package:learn/PieceRech.dart/fournisseur/ajout_four.dart';
import 'package:learn/PieceRech.dart/fournisseur/modifer_fourn.dart';
import 'package:learn/PieceRech.dart/fournisseur/rech_fourn.dart';

// ignore: must_be_immutable
class ConsulterFourn extends StatefulWidget {
  final docsid;
  const ConsulterFourn({Key? key, this.docsid}) : super(key: key);
  // ignore: library_private_types_in_public_api
  @override
  // ignore: library_private_types_in_public_api
  _ConsulterFournState createState() => _ConsulterFournState();
}

class _ConsulterFournState extends State<ConsulterFourn> {
  List fournisseur = [];

  CollectionReference fournref =FirebaseFirestore.instance.collection("Fournisseur");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        leading:  IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return const Article ();
                }
                ));
               }),
        title: const Text("List des Fournisseur",
            style: TextStyle(color: Colors.white)),
            actions: [ 
               IconButton(icon: const Icon(Icons.add), onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return const AjoutFour();
                }
                ));
               }),
               IconButton(icon: const Icon(Icons.search), onPressed: () {
                   Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return const RechFourn();
                }
                ));
               }),  
            ],
      ),
      body: 
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder(
              future: fournref.get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, i) {
                        return Card(
                          child: ListTile(
                          title:   Text("ID : ${snapshot.data!.docs[i]["ID"]}",
                                      style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             Text("Nom : ${snapshot.data!.docs[i]["Nom"]}",
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text("Adresse : ${snapshot.data!.docs[i]["Adresse"]}",
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                               Text("Numéro de Télephone : ${snapshot.data!.docs[i]["Numéro de Télephone "]}",
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text("Type de Commande : ${snapshot.data!.docs[i]["Type de Commande"]}",
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                            trailing: 
                                   SizedBox(
                                    width: 100,
                                    child: Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(builder: (context) {
                                              return EditFourn(BD: snapshot.data!.docs[i], docsid: snapshot.data!.docs[i].id);
                                            }));
                                          },
                                          icon: const Icon(Icons.edit, color: Colors.blueGrey),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            fournref.doc(snapshot.data!.docs[i].id).delete();
                                           setState(() {
                                             fournref.get();
                                           });
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return const AlertDialog(
                                                    title: Text("Succes"),
                                                    content: Text("Machine Supprimée"),
                                                  );
                                                });
                                          },
                                          
                                          icon: const Icon(Icons.delete, color: Colors.blueGrey),
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



