import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn/Equipements/consulter_equip.dart';

class FormInv extends StatefulWidget {
  const FormInv({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _FormInvState createState() => _FormInvState();
}

class _FormInvState extends State<FormInv> {

  CollectionReference equipref =FirebaseFirestore.instance.collection("bd_equip");

  final formstate = GlobalKey<FormState>();

  String? id, unite, marque, numero, designation, etat, date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Ajouter Equipement"),
          backgroundColor: Colors.blueGrey,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const Consulter();
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
                              return "Identifiant est obligatoire";
                            }
                            return null;
                          },
                          onSaved: (val) {
                            id = val;
                          },
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'ID',
                            prefixIcon: Icon(Icons.insert_drive_file, size: 25),
                          )),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "ce champs est obligatoire";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          designation = val;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Désignation',
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
                          marque = val;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Marque',
                          prefixIcon: Icon(Icons.type_specimen_rounded, size: 25),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Numreo n'est pas null";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          numero = val;
                        },
                        decoration: const InputDecoration(
                          hintText: "Numéro du modèle",
                          prefixIcon: Icon(Icons.numbers_rounded, size: 30),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "choisir l'unité du machine";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          unite = val;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Unité',
                          prefixIcon: Icon(Icons.type_specimen_rounded, size: 25),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "n'est pas vide";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Etat',
                          prefixIcon: Icon(Icons.verified_rounded, size: 25),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "n'est pas vide";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Date de mise en marche',
                          prefixIcon: Icon(Icons.date_range_rounded, size: 25),
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
                                      equipref.add({
                                        "ID": id,
                                        "Désignation": designation,
                                        "Marque": marque,
                                        "Date de mise en marche": date,
                                        "Numéro du modèle": numero,
                                        "Unité": unite,
                                        "Etat": etat,
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
                                              content: const Text("Equipement Ajoutée"),
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
