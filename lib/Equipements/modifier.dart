import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn/Equipements/consulter_equip.dart';

class Edit extends StatefulWidget {
  final String docsid;
  final BD;
  const Edit({Key? key,  required this.docsid, required this.BD}) : super(key: key);
  @override
  _EditState createState() => _EditState();
}
class _EditState extends State<Edit> {
  CollectionReference equipref =
      FirebaseFirestore.instance.collection("bd_equip");

  final formstate = GlobalKey<FormState>();

  String? id, unite, numero, desingation, marque, etat, date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Modifier Machine"),
          backgroundColor: Colors.blueGrey,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
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
                        initialValue: widget.BD["ID"] == null? "" : widget.BD["ID"].toString(),
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
                      initialValue: widget.BD["Désignation"] == null
                          ? ""
                          : widget.BD["Désignation"].toString(),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "ce champs est obligatoire";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        desingation = val;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Désingation',
                        prefixIcon:
                            Icon(Icons.mark_chat_read_rounded, size: 25),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      initialValue: widget.BD["Numéro du modèle"] == null
                          ? ""
                          : widget.BD["Numéro du modèle"].toString(),
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
                      initialValue: widget.BD["Unité"] == null
                          ? ""
                          : widget.BD["Unité"].toString(),
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
                      initialValue: widget.BD["Etat"] == null
                          ? ""
                          : widget.BD["Etat"].toString(),
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
                      initialValue:
                          widget.BD["Date de mise en marche"] == null ||
                                  widget.BD["Date de mise en marche"] == ""
                              ? ""
                              : widget.BD["Date de mise en marche"].toString(),
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
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(30),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () async {
                                  if (formstate.currentState!.validate()) {
                                    formstate.currentState!.save();
                                    try {
                                    await equipref.doc(widget.docsid).update({
                                     "ID": id,
                                     "Désingation": desingation,
                                     "Marque": marque,
                                     "Date de mise en marche": date,
                                     "Numéro du modèle": numero,
                                     "Unité": unite,
                                     "Etat": etat,
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
                                            title: Text("Succés"),
                                            content: Text("Machine Modifiée"),
                                          );
                                        });
                                       //Navigator.of(context).push(
                                      //MaterialPageRoute(
                                       // builder: (context) {
                                         // return const Consulter();
                                       // },),);
                                    } catch (e) {
                                      debugPrint("Error $e");
                                    }
                                  }
                                },
                                icon: const Icon(Icons.update),
                                label: const Text("Modifier"),
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
                                onPressed: () {},
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
