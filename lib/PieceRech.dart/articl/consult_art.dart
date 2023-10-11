import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn/PieceRech.dart/Article.dart';
import 'package:learn/PieceRech.dart/articl/ajout_art.dart';
import 'package:learn/PieceRech.dart/articl/modiifer_art.dart';
import 'package:learn/PieceRech.dart/articl/rech_article.dart';

// ignore: must_be_immutable
class ConsulterArt extends StatefulWidget {
  final docsid;
  const ConsulterArt({Key? key, this.docsid}) : super(key: key);
  // ignore: library_private_types_in_public_api
  @override
  // ignore: library_private_types_in_public_api
  _ConsulterArtState createState() => _ConsulterArtState();
}

class _ConsulterArtState extends State<ConsulterArt> {
  List article = [];

  CollectionReference articleref =FirebaseFirestore.instance.collection("Article");

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
        title: const Text("List des Articles",
            style: TextStyle(color: Colors.white)),
            actions: [ 
               IconButton(icon: const Icon(Icons.add), onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return const AjoutArt();
                }
                ));
               }),
               IconButton(
              icon: const Icon(Icons.search),
              onPressed: (){
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const RechArt();
                }));
              }),
        ],
      ),
      body: 
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder(
              future: articleref.get(),
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
                              Text("Fournisseur : ${snapshot.data!.docs[i]["Fournisseur"]}",
                                    style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text("Quantité :    ${snapshot.data!.docs[i]["Quantité"]}",
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
                                              return EditArticle(BD: snapshot.data!.docs[i], docsid: snapshot.data!.docs[i].id);
                                            }));
                                          },
                                          icon: const Icon(Icons.edit, color: Colors.blueGrey),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            articleref.doc(snapshot.data!.docs[i].id).delete();
                                           setState(() {
                                             articleref.get();
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


