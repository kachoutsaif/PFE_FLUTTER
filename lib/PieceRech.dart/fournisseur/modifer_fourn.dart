import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn/PieceRech.dart/fournisseur/consult_four.dart';

class EditFourn extends StatefulWidget {
  final String docsid;
  final BD;
  const EditFourn({Key? key,  required this.docsid, required this.BD}) : super(key: key);
  @override
  _EditFournState createState() => _EditFournState();
}
class _EditFournState extends State<EditFourn> {
  CollectionReference fournref =
      FirebaseFirestore.instance.collection("Fournisseur");

  final formstate = GlobalKey<FormState>();

String? id,adresse,numtel,numfax,cmde,activite,nom,rmque;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Modifier Fournisseur"),
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
                       validator : (val){
                        if (val!.isEmpty) {
                          return "Identifiant est obligatoire";
                        }
                        return null ;
                        },
                      onSaved: (val) {
                        id= val;
                        },
                        keyboardType: TextInputType.number,
                        decoration:  const InputDecoration (
                          hintText: 'ID',
                          prefixIcon: Icon(Icons.insert_drive_file_rounded, size:25),)
                    ),
                    TextFormField(
                      initialValue: widget.BD["Nom"] == null? "" : widget.BD["Nom"].toString(),
                      validator : (val){
                        if (val!.isEmpty) {
                          return "donner le nom";
                        }
                        return null ;
                        },
                      onSaved: (val) {
                        nom= val;
                        },
                      decoration:  const InputDecoration (
                        hintText: 'Nom',
                        prefixIcon: Icon(Icons.drive_file_rename_outline, size:25),),
                    ),
                    TextFormField(
                      initialValue: widget.BD["Adresse"] == null? "" : widget.BD["Adresse"].toString(),
                       validator : (val){
                        if (val!.isEmpty) {
                          return "donner l'adresse correspond";
                        }
                        return null;
                      }, 
                      onSaved: (val) {
                      adresse= val;
                      },
                      decoration:  const InputDecoration (
                        hintText: 'Adresse',
                        prefixIcon: Icon(Icons.place_outlined,size:25),),
                    ),
                    TextFormField(
                      initialValue: widget.BD["Numéro de Télephone"] == null? "" : widget.BD["Numéro de Télephone"].toString(),
                       validator : (val){
                        if (val!.isEmpty) {
                          return "remplire ce champs";
                        }
                        return null;
                      }, 
                      onSaved: (val) {
                      numtel= val;
                      },
                      decoration:  const InputDecoration (
                        hintText: "Numéro de Télephone",
                        prefixIcon: Icon(Icons.phone, size: 30),),
                    ),
                    TextFormField(
                       initialValue: widget.BD["Numéro de Fax"] == null? "" : widget.BD["Numéro de Fax"].toString(),
                       validator : (val){
                        if (val!.isEmpty) {
                          return "ce champs est obligatoire";
                        }
                        return null;
                      }, 
                      onSaved: (val) {
                      numfax= val;
                      },
                      decoration:  const InputDecoration (
                        hintText: "Numéro de Fax",
                        prefixIcon: Icon(Icons.phone,size:25 ),),
                    ),
                    TextFormField(
                       initialValue: widget.BD["Activité"] == null? "" : widget.BD["Activité"].toString(),
                       validator : (val){
                        if (val!.isEmpty) {
                          return "ce champs est obligatoire";
                        }
                        return null;
                      }, 
                      onSaved: (val) {
                      activite= val;
                      },
                      decoration:  const InputDecoration (
                        hintText: 'Activité',
                        prefixIcon: Icon(Icons.local_activity_outlined,size:25),),
                    ),
                    TextFormField(
                      initialValue: widget.BD["Type de Commande"] == null? "" : widget.BD["Type de Commande"].toString(),
                       validator : (val){
                        if (val!.isEmpty) {
                          return "ce champs est obligatoire";
                        }
                        return null;
                      }, 
                      onSaved: (val) {
                      cmde= val;
                      },
                      decoration:  const InputDecoration (
                        hintText: 'Type de Commande',
                        prefixIcon: Icon(Icons.keyboard_command_key_outlined,size:25),),
                    ),
                    TextFormField(
                       initialValue: widget.BD["Remarque"] == null? "" : widget.BD["Remarque"].toString(),
                      validator : (val){
                        if (val!.isEmpty) {
                          return "ce champs est obligatoire";
                        }
                        return null;
                      }, 
                      onSaved: (val) {
                      rmque= val;
                      },
                      decoration:  const InputDecoration (
                        hintText: 'Remarque',
                        prefixIcon: Icon(Icons.note_add_outlined,size:25),),
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
                                    await fournref.doc(widget.docsid).update({
                                        "ID" : id,
                                        "Nom" : nom,
                                        "Numéro de Télephone" : numtel,
                                        "Numéro de Fax" : numfax,
                                        "Activité" : activite,
                                        "Type de Commande" : cmde,
                                        "Remarque" : rmque,
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
                                                  return const ConsulterFourn();},),);
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
