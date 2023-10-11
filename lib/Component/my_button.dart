import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  const MyButton({super.key, required this.onTap, required String label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 270,
      height: 50,
      child: ElevatedButton(
          onPressed: onTap ,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Colors.black,
          ),
          child: const Text(
            "Sign In",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          )),
    );
  }
}
