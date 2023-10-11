import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn/PieceRech.dart/articl/consult_art.dart';

class AjoutArt extends StatefulWidget {

   const AjoutArt({Key? key}) : super (key: key);

    @override
    AjoutArtState createState() => AjoutArtState();
}
  class AjoutArtState extends State<AjoutArt> {
  
  List article= [] ;
 CollectionReference articleref = FirebaseFirestore.instance.collection("Article");

 final formstate = GlobalKey<FormState>();

String? id,nom,designation,fourn,qtit,date;
  @override
  Widget build(BuildContext context) {
         return  Scaffold(
        appBar: AppBar(
          title:  const Text("Gestion Article"),
          backgroundColor: Colors.blueGrey,
          leading: IconButton(icon: const Icon(Icons.arrow_back),onPressed: (){
            Navigator.of(context)
            .push(MaterialPageRoute(builder: (context)
            { return const ConsulterArt(); }));
          }),
          actions:  [
            IconButton(icon: const Icon(Icons.search_rounded),onPressed: (){} ) ,
          ],
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
                          prefixIcon: Icon(Icons.room_preferences_outlined, size:25),)
                    ),
                     const SizedBox(height: 20),
                    TextFormField(
                      validator : (val){
                        if (val!.isEmpty) {
                          return "ce champs est obligatoire";
                        }
                        return null;
                      }, 
                      onSaved: (val) {
                      nom= val;
                      },
                      decoration:  const InputDecoration (
                        hintText: 'Nom',
                        prefixIcon: Icon(Icons.drive_file_rename_outline, size:25),),
                    ),
                     const SizedBox(height: 20),
                    TextFormField(
                      validator : (val){
                        if (val!.isEmpty) {
                          return "ce champs est obligatoire";
                        }
                        return null;
                      }, 
                      onSaved: (val) {
                      designation= val;
                      },
                      decoration:  const InputDecoration (
                        hintText: 'Désignation',
                        prefixIcon: Icon(Icons.description_outlined,size:25),),
                    ),
                     const SizedBox(height: 20),
                    TextFormField(
                      validator : (val){
                        if (val!.isEmpty) {
                          return "ce champs est obligatoire";
                        }
                        return null;
                      }, 
                      onSaved: (val) {
                        fourn= val;
                      },
                      decoration:  const InputDecoration (
                        hintText: 'Fournisseur',
                        prefixIcon: Icon(Icons.keyboard_command_key_outlined, size: 30),),
                    ),
                     const SizedBox(height: 20),
                    TextFormField(
                       validator : (val){
                        if (val!.isEmpty) {
                          return "ce champs est obligatoire";
                        }
                        return null;
                        }, 
                      onSaved: (val) {
                        fourn= val;
                       },
                      decoration:  const InputDecoration (
                        hintText: "Quantité",
                        prefixIcon: Icon(Icons.production_quantity_limits_outlined,size:25 ),),
                    ),
                     const SizedBox(height: 20),
                    TextFormField(
                       validator : (val){
                        if (val!.isEmpty) {
                          return "ce champs est obligatoire";
                        }
                        return null;
                      }, 
                      onSaved: (val) {
                        date= val;
                      },
                      decoration:  const InputDecoration (
                        hintText: 'Date de Réception',
                        prefixIcon: Icon(Icons.date_range_outlined,size:25),),
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
                                       articleref.add({
                                        "ID": id,
                                        "Nom": nom,
                                        "Désignation": designation,
                                        "Fournisseur": fourn,
                                        "Quantité": qtit,
                                        "Date de Réception": date,
                                      }).then((value) => print(value.id));;
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
                                                TextButton(onPressed: (){
                                                  Navigator.of(context).pop();
                                                } , child: const Text("Annuler")),
                                              ],
                                              title: const Text("Succés"),
                                              content: const Text("Article Ajoutée"),
                                            );
                                          });
                                    } catch (e) {
                                      debugPrint("Error $e");
                                    }
                                  }

                                  // ignore: use_build_context_synchronously
                                  //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)
                                  //{ return const ConsulterArt(); }));
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