import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Machine {
  int id;
  String designation;
  String marque;
  String unite;
  String etat;
  String date;
  String numero;

  Machine({
    required this.id,
    required this.designation,
    required this.marque,
    required this.unite,
    required this.etat,
    required this.date,
    required this.numero,
  });

  factory Machine.fromMap(Map<String, dynamic> map) {
    return Machine(
      id: map['id'],
      designation: map['designation'],
      marque: map['marque'],
      unite: map['unite'],
      etat: map['etat'],
      date: map['date'],
      numero: map['numero'],
    );
  }
  static Future<Machine?> getMachineByIdFromFirestore(int machineId) async {
  final CollectionReference machinesCollection =
      FirebaseFirestore.instance.collection('bd_equip');

  try {
    final QuerySnapshot snapshot =
        await machinesCollection.where('ID', isEqualTo: machineId).limit(1).get();

    if (snapshot.docs.isNotEmpty) {
      final Object? data = snapshot.docs.first.data();
      if (data != null) {
        return data as Machine;
      }
    }
  } catch (e) {
    throw Exception('Failed to get machine: $e');
  }

  return null; // Return null if machine is not found
}


}
const String jsonString = '{"id":1,"designation":"Machine 1","marque":"Marque 1","unite":"Unité 1","etat":"En marche","date":"2022-05-15","numero":"123456"}';
final Map<String, dynamic> jsonMap = json.decode(jsonString);
final Machine machine = Machine.fromMap(jsonMap);

