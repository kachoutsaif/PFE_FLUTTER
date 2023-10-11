import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn/PieceRech.dart/articl/consult_art.dart';

class EditArticle extends StatefulWidget {
  final String docsid;
  final BD;
  const EditArticle({Key? key,  required this.docsid, required this.BD}) : super(key: key);
  @override
  _EditArticleState createState() => _EditArticleState();
}
class _EditArticleState extends State<EditArticle> {
  CollectionReference articleref =
      FirebaseFirestore.instance.collection("Article");

  final formstate = GlobalKey<FormState>();

  String? id, fourn, desingation,nom, qtit, date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Modifier Article"),
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
                      initialValue: widget.BD["Fournisseur"] == null
                          ? ""
                          : widget.BD["Fournisseur"].toString(),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "ce champs est obligatoire ";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        fourn = val;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Fournisseur',
                        prefixIcon: Icon(Icons.type_specimen_rounded, size: 25),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      initialValue: widget.BD["Nom"] == null
                          ? ""
                          : widget.BD["Nom"].toString(),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Nom est obligatoire";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        nom = val;
                      },
                      decoration: const InputDecoration(
                        hintText: "Nom",
                        prefixIcon: Icon(Icons.numbers_rounded, size: 30),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      initialValue: widget.BD["Quantité"] == null
                          ? ""
                          : widget.BD["Quantité"].toString(),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Taper la Quantité";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        qtit = val;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Quantité',
                        prefixIcon: Icon(Icons.type_specimen_rounded, size: 25),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      initialValue: widget.BD["Date de Réception"] == null
                          ? ""
                          : widget.BD["Date de Réception"].toString(),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "choisir la date";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Date de Réception',
                        prefixIcon: Icon(Icons.verified_rounded, size: 25),
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
                                    await articleref.doc(widget.docsid).update({
                                        "ID": id,
                                        "Nom": nom,
                                        "Désignation": desingation,
                                        "Fournisseur": fourn,
                                        "Quantité": qtit,
                                        "Date de Réception": date,
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
                                                  return const ConsulterArt();},),);
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
