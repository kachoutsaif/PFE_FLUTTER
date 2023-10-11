import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn/PieceRech.dart/articl/modiifer_art.dart';
import 'package:learn/PieceRech.dart/fournisseur/modifer_fourn.dart';

class RechFourn extends StatefulWidget {
  final docsid;
  const RechFourn({Key? key, this.docsid}) : super(key: key);
  @override
  _RechFournState createState() => _RechFournState();
}

class _RechFournState extends State<RechFourn> {
  // ignore: non_constant_identifier_names
    CollectionReference fournref =FirebaseFirestore.instance.collection("Fournisseur");
 String rech ='';
List <Map <String , dynamic>> data = [
  
];
List <Map <String , dynamic>> recherch = [];

torecherche (String quary) async {
  List <Map <String , dynamic>> result = [];
  if (quary.isEmpty) {
    recherch = result;
  } else {

  }
}

 addData() async {
  for (var element in data) {
    FirebaseFirestore.instance.collection("Fournisseur").add(element);
  }
  print("all data added");
 }
 
@override
void initState(){
  super.initState();
  addData();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.blueGrey,
      title:  Card(
        child: TextField(
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),hintText: 'Search ...'),
            onChanged: (val){
              setState(() {
                rech= val;
              });
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot> (
        stream: FirebaseFirestore.instance.collection("Fournisseur").snapshots(),
        builder: (context,snapshots){
           return (snapshots.connectionState == ConnectionState.waiting) 
           ? const Center( child: CircularProgressIndicator(),
           ) : ListView.builder(
            itemCount: snapshots.data!.docs.length,
            itemBuilder: (context , i) {
              //var data = snapshots.data!.docs[i].data() as Map<String , dynamic>;
              if (rech.isEmpty){
                 return Card(
                          child: ListTile(
                          title:   Text("ID : ${snapshots.data!.docs[i]["ID"]}",
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text("Nom : ${snapshots.data!.docs[i]["Nom"]}",
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text("Adresse : ${snapshots.data!.docs[i]["Adresse"]}",
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                               Text("Numéro de Télephone : ${snapshots.data!.docs[i]["Numéro de Télephone "]}",
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text("Type de Commande : ${snapshots.data!.docs[i]["Type de Commande"]}",
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
                                              return EditArticle(BD: snapshots.data!.docs[i], docsid: snapshots.data!.docs[i].id);
                                            }));
                                          },
                                          icon: const Icon(Icons.edit, color: Colors.blueGrey),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            fournref.doc(snapshots.data!.docs[i].id).delete();
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
              }
              else if (snapshots.data!.docs[i]["ID"].toString().contains(rech)) {
                return Card(
                          child: ListTile(
                          title:   Text("ID : ${snapshots.data!.docs[i]["ID"]}",
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             Text("Nom : ${snapshots.data!.docs[i]["Nom"]}",
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text("Adresse : ${snapshots.data!.docs[i]["Adresse"]}",
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                               Text("Numéro de Télephone : ${snapshots.data!.docs[i]["Numéro de Télephone "]}",
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text("Type de Commande : ${snapshots.data!.docs[i]["Type de Commande"]}",
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
                                              return EditFourn(BD: snapshots.data!.docs[i], docsid: snapshots.data!.docs[i].id);
                                            }));
                                          },
                                          icon: const Icon(Icons.edit, color: Colors.blueGrey),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            fournref.doc(snapshots.data!.docs[i].id).delete();
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
              }
              return Container();
            }
            );
        }
      )
    );
  }
}