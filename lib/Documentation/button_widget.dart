import 'package:flutter/material.dart';


class ButtonWidget extends StatelessWidget {
  final IconData icon ;
  final String text ;
  final VoidCallback onClicked ;
  
  const ButtonWidget({
    super.key, 
    Key? Key,
    required this.icon,
    required this.text,
    required this.onClicked,
  });
  
@override
  Widget build  (BuildContext context) => ElevatedButton(
        style : ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(29, 194, 95, 1),
          minimumSize: const Size.fromHeight(50), 
        ),
        onPressed: onClicked,
        child: buildContent(),
        );

  Widget buildContent() => Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Icon(icon, size: 28),
      const SizedBox(width: 16),
      Text(
        text,
        style: const TextStyle(fontSize: 22, color: Colors.white),
      )
    ],
  );
} 
