import 'package:flutter/material.dart';
import 'package:learn/Component/password.dart';
import 'package:learn/Menu/menu_page.dart';
import 'package:learn/Component/signup.dart';
import 'package:learn/Component/loginpage2.dart';
import 'package:learn/Component/my_button.dart';
import 'package:learn/Component/my_textfield.dart';
import 'package:learn/Component/square_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: must_be_immutable, use_key_in_widget_constructors
class SignIn extends StatelessWidget {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
            child: Form(
                key: formstate,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100),
                    const Icon(
                      Icons.lock,
                      size: 100,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Welcome back",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    MyTextField(
                      onSaved: (val) {
                      },
                      validator: (String val) {
                        if (val.isEmpty) {
                          return "Email invalide";
                        }
                        return null;
                      },
                      controller: usernameController,
                      hintText: 'Email',
                      obscureText: false,
                      prefixIcon: const Icon(Icons.person, size: 20),
                    ),
                    const SizedBox(height: 10),
                    MyTextField(
                      onSaved: (val) {
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Password invalide";
                        }
                        return null;
                      },
                      controller: passwordController,
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.key, size: 20),
                      obscureText: true, 
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                                Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const ResetPasswordPage()),
                                      ); 
                            },
                            child: Text(
                              "Forget Password?",
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    MyButton(
                      onTap: () async {
                        if (formstate.currentState!.validate()) {
                          try {
                            await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                      email: usernameController.text.trim(),
                                      password: passwordController.text.trim(),
                                    );
                             // ignore: use_build_context_synchronously
                             Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const MenuPage()),
                                      ); // 👈 add your navigatin inside then block
                                // ignore: curly_braces_in_flow_control_structures
                                } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              debugPrint('No user found for that email.');
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const AlertDialog(
                                      title: Text("Error"),
                                      content: Text(
                                          "No user found for that email.'"),
                                      );
                                  });
                            } else if (e.code == 'wrong-password') {
                              debugPrint(
                                  'Wrong password provided for that user.');
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const AlertDialog(
                                      title: Text("Error"),
                                      content: Text(
                                          "Wrong password provided for that user."),
                                    );
                                  });
                            }
                          }
                        }
                      }, label: '',
                    ),
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'Or continue with',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                       Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const LoginPage()),
                                      ); 
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SquareTile(imagePath: 'lib/images/p1.jpg')
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Not a member?",
                            style: TextStyle(color: Colors.grey[700])),
                        const SizedBox(width: 4),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return const SignUp();
                            }));
                          },
                          child: const Text(
                            "Register Now",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  ],
                ))),
      ),
    );
  }
}
