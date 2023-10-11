import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn/Equipements/consulter_equip.dart';
import 'package:learn/Interventions/historique/consulter_hist.dart';

class Ajouthistorique extends StatefulWidget {
  const Ajouthistorique({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _AjouthistoriqueState createState() => _AjouthistoriqueState();
}

class _AjouthistoriqueState extends State<Ajouthistorique> {

  CollectionReference histref =FirebaseFirestore.instance.collection("Historique");

  final formstate = GlobalKey<FormState>();

  String?  machine, intervention,date , type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Ajouter Historique"),
          backgroundColor: Colors.blueGrey,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const ConsulterHist();
                }));
              }),
          shadowColor: Colors.blueGrey,
          elevation: 25,
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formstate,
                child: Column(
                  children: [
                      TextFormField(
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Remplir la date";
                            }
                            return null;
                          },
                          onSaved: (val) {
                            date = val;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Date',
                            prefixIcon: Icon(Icons.date_range_rounded, size: 25),
                          )),
                      const SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "ce champs est obligatoire";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          machine = val;
                        },
                        decoration: const InputDecoration(
                          hintText: 'MachinID',
                          prefixIcon:
                              Icon(Icons.mark_chat_read_rounded, size: 25),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "ce champs est obligatoire ";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          intervention = val;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Intervention',
                          prefixIcon: Icon(Icons.integration_instructions, size: 25),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "ce champs est obligatoire";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          type = val;
                        },
                        decoration: const InputDecoration(
                          hintText: "Type",
                          prefixIcon: Icon(Icons.type_specimen, size: 30),
                        ),
                      ),
                    const SizedBox(height: 20),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(30),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  if (formstate.currentState!.validate()) {
                                    formstate.currentState!.save();
                                    try {
                                      histref.add({
                                        "MachineID": machine,
                                        "Date": date,
                                        "Interventions": intervention,
                                        "Type": type,
                                      }
                                      ).then((value) => print(value.id));
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
                                                TextButton(onPressed: (){
                                                  Navigator.of(context).pop();
                                                } , child: const Text("Annuler")),
                                              ],
                                              title: const Text("Succés"),
                                              content: const Text("historique Ajoutée"),
                                            );
                                          });
                                           //Navigator.of(context).push(
                                            //MaterialPageRoute(
                                            //builder: (context) {
                                            //return const Consulter();
                                            //},),);
                                    } catch (e) {
                                      debugPrint("Error $e");
                                    }
                                  }
                                },
                                
                                icon: const Icon(Icons.add_circle_rounded),
                                label: const Text("Ajouter"),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueGrey,
                                    padding: const EdgeInsets.all(10),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    shadowColor: Colors.grey,
                                    textStyle: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton.icon(
                                onPressed: () {
                                  formstate.currentState!.reset();
                                },
                                icon: const Icon(Icons.delete),
                                label: const Text("Annuler"),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueGrey,
                                    padding: const EdgeInsets.all(10),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    shadowColor: Colors.grey,
                                    textStyle: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
