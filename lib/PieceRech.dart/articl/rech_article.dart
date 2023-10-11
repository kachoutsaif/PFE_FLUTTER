import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn/PieceRech.dart/articl/modiifer_art.dart';

class RechArt extends StatefulWidget {
  final docsid;
  const RechArt({Key? key, this.docsid}) : super(key: key);
  @override
  _RechArtState createState() => _RechArtState();
}

class _RechArtState extends State<RechArt> {
  // ignore: non_constant_identifier_names
    CollectionReference artref =FirebaseFirestore.instance.collection("Article");
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
    FirebaseFirestore.instance.collection("Article").add(element);
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
        stream: FirebaseFirestore.instance.collection("Article").snapshots(),
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
                              Text("Fournisseur : ${snapshots.data!.docs[i]["Fournisseur"]}",
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text("Quantité : ${snapshots.data!.docs[i]["Quantité"]}",
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
                                            artref.doc(snapshots.data!.docs[i].id).delete();
                                           setState(() {
                                             artref.get();
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
                              Text("Fournisseur : ${snapshots.data!.docs[i]["Fournisseur"]}",
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text("Quantité : ${snapshots.data!.docs[i]["Quantité"]}",
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
                                            artref.doc(snapshots.data!.docs[i].id).delete();
                                           setState(() {
                                            artref.get();
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