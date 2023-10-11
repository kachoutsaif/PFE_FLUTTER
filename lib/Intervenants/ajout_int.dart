import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn/Intervenants/conslt_interv.dart';
import 'package:date_field/date_field.dart';

class AjoutInterv extends StatefulWidget {
  const AjoutInterv({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _AjoutIntervState createState() => _AjoutIntervState();
}

class _AjoutIntervState extends State<AjoutInterv> {

  CollectionReference intervref =FirebaseFirestore.instance.collection("Intervention");

  final formstate = GlobalKey<FormState>();

var _selectedDate = DateTime.now();

  String?  matricule, intervention,unite,nom,type;
  DateTime? date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Ajouter Intervention"),
          backgroundColor: Colors.blueGrey,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const ConsulterIntervn();
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
                      DateTimeFormField(
                        onDateSelected : (DateTime value) {
                        setState((){
                            _selectedDate = value;
                        });
                        },
                          validator: (DateTime ?dateTime) {
                            if (dateTime == null) {
                              return "Remplir la date";
                            }
                            return null;
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
                          matricule = val;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Matricule',
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
                          nom = val;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Nom',
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
                          unite = val;
                        },
                        decoration: const InputDecoration(
                          hintText: "Unité",
                          prefixIcon: Icon(Icons.type_specimen, size: 30),
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
                          intervention = val;
                        },
                        decoration: const InputDecoration(
                          hintText: "Intervention",
                          prefixIcon: Icon(Icons.type_specimen, size: 30),
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
                            hintText: 'Type',
                            prefixIcon: Icon(Icons.date_range_rounded, size: 25),
                          )),
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
                                      intervref.add({
                                        "Date" : _selectedDate,
                                        "Matricule" : matricule,
                                        "Nom" : nom,
                                        "Unité" : unite,
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
                                                  return const ConsulterIntervn();},),);
                                                } ,
                                                child: const Text("OK")),
                                                TextButton(onPressed: (){
                                                  Navigator.of(context).pop();
                                                } , child: const Text("Annuler")),
                                              ],
                                              title: const Text("Succés"),
                                              content: const Text("Intervention Ajoutée"),
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
