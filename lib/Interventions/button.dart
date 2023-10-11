
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn/Interventions/theme.dart';

class MyButtonTask extends StatelessWidget {
  final String label;
  final Function()? onTap;
const MyButtonTask({ Key? key, required this.label, required this.onTap }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return GestureDetector(
       onTap: onTap,
       child : Container(
        width: 100,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: primaryClr,
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
       )
    );
  }
}