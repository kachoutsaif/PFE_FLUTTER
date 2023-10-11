import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn/PieceRech.dart/fournisseur/consult_four.dart';

class AjoutFour extends StatefulWidget {

  const AjoutFour({super.key});
_AjoutFourState createState() => _AjoutFourState();

}
  class _AjoutFourState extends State<AjoutFour> {
  
  List fournisseur= [] ;
 CollectionReference fournref = FirebaseFirestore.instance.collection("Fournisseurs");

final formstate = GlobalKey<FormState>();

String? id,adresse,numtel,numfax,cmde,activite,nom,rmque;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title:  const Text("Gestion Fournisseur"),
          backgroundColor: Colors.blueGrey,
          leading: IconButton(icon: const Icon(Icons.arrow_back),onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)
            { return const ConsulterFourn(); }));
          }),
          shadowColor: Colors.blueGrey,
          elevation: 25,
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(20),
          child: Center(
            child: Form(
              key: formstate,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    TextFormField(
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
                    const SizedBox(height: 10,),
                    TextFormField(
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
                      const SizedBox(height: 10,),
                    TextFormField(
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
                      const SizedBox(height: 10,),
                    TextFormField(
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
                    const SizedBox(height: 10,),
                    TextFormField(
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
                    const SizedBox(height: 10,),
                    TextFormField(
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
                    const SizedBox(height: 10,),
                    TextFormField(
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
                    const SizedBox(height: 10,),
                    TextFormField(
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
                                onPressed:() {
                                   if (formstate.currentState!.validate()) {
                                    formstate.currentState!.save();
                                    try {
                                      fournref.add({
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
                                                TextButton(onPressed: (){
                                                  Navigator.of(context).pop();
                                                } , child: const Text("Annuler")),
                                              ],
                                              title: const Text("Succés"),
                                              content: const Text("Fournisseur Ajoutée"),
                                            );
                                          });
                                     } catch (e) {
                                      debugPrint("Error $e");
                                    }
                                  }
                                  
                                  // // ignore: use_build_context_synchronously
                                  // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)
                                  // { return const ConsulterArt(); }));
                                },
                                icon: const Icon(Icons.add_circle_rounded),
                                label: const Text("Ajouter"),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueGrey,
                                    padding: const EdgeInsets.all(10),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)) ,
                                    shadowColor: Colors.grey,
                                    textStyle: const TextStyle(color: Colors.black54,fontSize: 15,fontWeight: FontWeight.bold,)
                                ),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton.icon(
                                onPressed:(){
                                   formstate.currentState!.reset();
                                },
                                icon: const Icon(Icons.delete),
                                label: const Text("Annuler"),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueGrey,
                                    padding: const EdgeInsets.all(10),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)) ,
                                    shadowColor: Colors.grey,
                                    textStyle: const TextStyle(color: Colors.black54,fontSize: 15,fontWeight: FontWeight.bold,)
                                ),
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
        )
    );
  }
}