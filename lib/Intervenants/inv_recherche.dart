import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn/Intervenants/modif_interv.dart';

class InterRecherche extends StatefulWidget {
  final docsid;
  const InterRecherche({Key? key, this.docsid}) : super(key: key);
  @override
  _RechercheState createState() => _RechercheState();
}

class _RechercheState extends State<InterRecherche> {
  // ignore: non_constant_identifier_names
    CollectionReference interref =FirebaseFirestore.instance.collection("Intervention");
 String rech ='';
List <Map <String , dynamic>> data = [
  
];
List <Map <String , dynamic>> recherch = [
  
];

torecherche (String quary) async {
  List <Map <String , dynamic>> result = [];
  if (quary.isEmpty) {
    recherch = result;
  } else {

  }
}

 addData() async {
  for (var element in data) {
    FirebaseFirestore.instance.collection("Intervention").add(element);
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
        stream: FirebaseFirestore.instance.collection("Intervention").snapshots(),
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
                          title:   Text("Matricule : ${snapshots.data!.docs[i]["Matricule"]}",
                                       style: const TextStyle(fontWeight: FontWeight.bold),),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Date : ${snapshots.data!.docs[i]["Date"].toDate()}",
                               style: const TextStyle(fontWeight: FontWeight.bold),),
                              Text("Interventions : ${snapshots.data!.docs[i]["Interventions"]}",
                               style: const TextStyle(fontWeight: FontWeight.bold),),
                              Text("Unité : ${snapshots.data!.docs[i]["Unité"]}",
                               style: const TextStyle(fontWeight: FontWeight.bold),),
                              Text("Type : ${snapshots.data!.docs[i]["Type"]}",
                               style: const TextStyle(fontWeight: FontWeight.bold),),
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
                                              return ModifierInterv(BD: snapshots.data!.docs[i], docsid: snapshots.data!.docs[i].id);
                                            }));
                                          },
                                          icon: const Icon(Icons.edit, color: Colors.blueGrey),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            interref.doc(snapshots.data!.docs[i].id).delete();
                                           setState(() {
                                             interref.get();
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
              else if (snapshots.data!.docs[i]["Matricule"].toString().contains(rech)) {
                return Card(
                          child: ListTile(
                          title:   Text("Matricule : ${snapshots.data!.docs[i]["Matricule"]}"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Date : ${snapshots.data!.docs[i]["Date"].toDate()}",
                               style: const TextStyle(fontWeight: FontWeight.bold),),
                              Text("Interventions : ${snapshots.data!.docs[i]["Interventions"]}",
                               style: const TextStyle(fontWeight: FontWeight.bold),),
                              Text("Unité : ${snapshots.data!.docs[i]["Unité"]}",
                               style: const TextStyle(fontWeight: FontWeight.bold),),
                              Text("Type : ${snapshots.data!.docs[i]["Type"]}",
                               style: const TextStyle(fontWeight: FontWeight.bold),),
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
                                              return ModifierInterv(BD: snapshots.data!.docs[i], docsid: snapshots.data!.docs[i].id);
                                            }));
                                          },
                                          icon: const Icon(Icons.edit, color: Colors.blueGrey),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            interref.doc(snapshots.data!.docs[i].id).delete();
                                           setState(() {
                                             interref.get();
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