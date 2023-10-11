import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:learn/Intervenants/conslt_interv.dart';

class ModifierInterv extends StatefulWidget {
  final String docsid;
  final BD;
  const ModifierInterv({Key? key, required this.docsid, required this.BD}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _ModifierIntervState createState() => _ModifierIntervState();
}

class _ModifierIntervState extends State<ModifierInterv> {

  CollectionReference intervref =FirebaseFirestore.instance.collection("Intervention");

  final formstate = GlobalKey<FormState>();
  
var _selectedDate = DateTime.now();

  String?  matricule, intervention, unite,nom;
  DateTime? date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Modifier Intervention"),
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
                        initialValue: widget.BD["Date"] == null ? "" : widget.BD["Date"].toDate(),
                        mode: DateTimeFieldPickerMode.date,
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
                          onSaved: (value) {
                              date= value ;
                            },
                          decoration: const InputDecoration(
                            hintText: 'Date',
                            prefixIcon: Icon(Icons.date_range_rounded, size: 25),
                          )),
                      const SizedBox(height: 20),
                      TextFormField(
                        initialValue: widget.BD["Matricule"] == null? "" : widget.BD["Matricule"].toString(),
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
                        initialValue: widget.BD["Nom"] == null? "" : widget.BD["Nom"].toString(),
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
                        initialValue: widget.BD["Unité"] == null? "" : widget.BD["Unité"].toString(),
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
                      initialValue: widget.BD["Interventions"] == null? "" : widget.BD["Interventions"].toString(),
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
                          hintText: "Interventions",
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
                                onPressed: () async {
                                  if (formstate.currentState!.validate()) {
                                    formstate.currentState!.save();
                                    try {
                                      await intervref.doc(widget.docsid).update({
                                        "Date" : date,
                                        "Matricule" : matricule,
                                        "Nom" : nom,
                                        "Unité" : unite,
                                        "Interventions": intervention,
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
                                                  return const ConsulterIntervn();},),);
                                                } ,
                                                child: const Text("OK")),
                                                TextButton(onPressed: (){
                                                  Navigator.of(context).pop();
                                                } , child: const Text("Annuler")),
                                              ],
                                              title: const Text("Succés"),
                                              content: const Text("Intervention Modifée"),
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
