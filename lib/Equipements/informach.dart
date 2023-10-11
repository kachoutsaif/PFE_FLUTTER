import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn/Code%20QR/machine.dart';
import 'package:learn/Menu/menu_page.dart';

class InfoMach extends StatefulWidget {
  final String docsid;
     const InfoMach({Key? key,  required this.docsid}) : super(key: key);

  @override
  _InfoMachState createState() => _InfoMachState();

  initState(){
  }
  intialize() async{
    Machine? machine = await Machine.getMachineByIdFromFirestore(int.parse(docsid));
  }
}


class _InfoMachState extends State<InfoMach> {
  CollectionReference equipref =
      FirebaseFirestore.instance.collection("bd_equip");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Les Informations"),
        backgroundColor: Colors.blueGrey,
        leading:  IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const MenuPage();
                }));
              }),
      ),
      body:  
      Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
          child: Column(
                      children: [
                          TextFormField(
                            initialValue: machine.id.toString(),
                              decoration: const InputDecoration(
                                hintText: 'ID',
                                prefixIcon: Icon(Icons.insert_drive_file, size: 25),
                              )),
                          const SizedBox(height: 20),
                          TextFormField(
                            initialValue: machine.designation.toString(),
                            decoration: const InputDecoration(
                              hintText: 'Désignation',
                              prefixIcon:
                                  Icon(Icons.mark_chat_read_rounded, size: 25),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            initialValue: machine.marque.toString(),
                            decoration: const InputDecoration(
                              hintText: 'Marque',
                              prefixIcon: Icon(Icons.type_specimen_rounded, size: 25),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            initialValue: machine.numero.toString(),
                            decoration: const InputDecoration(
                              hintText: "Numéro du modèle",
                              prefixIcon: Icon(Icons.numbers_rounded, size: 30),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                             initialValue: machine.unite.toString(),
                            decoration: const InputDecoration(
                              hintText: 'Unité',
                              prefixIcon: Icon(Icons.type_specimen_rounded, size: 25),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            initialValue: machine.etat.toString(),
                            decoration: const InputDecoration(
                              hintText: 'Etat',
                              prefixIcon: Icon(Icons.verified_rounded, size: 25),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                             initialValue: machine.date.toString(),
                            decoration: const InputDecoration(
                              hintText: 'Date de mise en marche',
                              prefixIcon: Icon(Icons.date_range_rounded, size: 25),
                            ),
                          ),
                      ]
              ),
          ),
    );
  }
}