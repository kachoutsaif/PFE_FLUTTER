import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:learn/Menu/menu_page.dart';
import 'package:learn/Component/signin.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? myusername, mypassword, myemail;

  final GlobalKey<FormState> formstate = GlobalKey<FormState>();

  // ignore: non_constant_identifier_names
  Future SingUp() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      // try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: myemail!,
        password: mypassword!,
      );
      return userCredential;
      //   } on FirebaseAuthException catch (e) {
      //     if (e.code == 'weak-password') {
      //       return showDialog(
      //           context: context,
      //           builder: (context) {
      //             return const AlertDialog(
      //               backgroundColor: Colors.blueGrey,
      //               title: Text("Error"),
      //               content: Text("Password is to weak"),
      //             );
      //           });
      //     } else if (e.code == 'email-already-in-use') {
      //       showDialog(
      //           context: context,
      //           builder: (context) {
      //             return const AlertDialog(
      //               title: Text("Error"),
      //               content: Text("the account already exist"),
      //             );
      //           });
      //       debugPrint('The account already exists for that email.');
      //     }
      //   } catch (e) {
      //     debugPrint(e.toString());
      //   }
      // } else {
      //   debugPrint("Not Valid");
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Creation du Compte"),
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
            child: Form(
              key: formstate,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    TextFormField(
                        onSaved: (val) {
                          myusername = val;
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "ce champs est obligatoire";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'UserName',
                          prefixIcon: Icon(Icons.person, size: 25),
                        )),
                    const SizedBox(height: 20),
                    TextFormField(
                      onSaved: (val) {
                        myemail = val;
                      },
                      validator: (val) {
                        if (val!.length > 100) {
                          return "Email can't be larger than 100 letter";
                        }
                        if (val.length < 2) {
                          return "Email can't be less than 2 letter";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email, size: 25),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      onSaved: (val) {
                        mypassword = val;
                      },
                      validator: (val) {
                        if (val!.length > 100) {
                          return "Password can't be larger than 100 letter";
                        }
                        if (val.length < 4) {
                          return "Password can't be less than 4 letter";
                        }
                        return null;
                      },
                      obscureText: false,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.key_outlined, size: 25),
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
                                  try {
                                    await SingUp().then((result) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignIn()),
                                      ); // 👈 add your navigatin inside then block
                                    });
                                  } catch (e) {
                                    if (e.toString() == 'weak-password') {
                                      return showDialog(
                                          context: context,
                                          builder: (context) {
                                            return const AlertDialog(
                                              backgroundColor: Colors.blueGrey,
                                              title: Text("Error"),
                                              content:
                                                  Text("Password is to weak"),
                                            );
                                          });
                                    } else if (e.toString() ==
                                        'email-already-in-use') {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return const AlertDialog(
                                              title: Text("Error"),
                                              content: Text(
                                                  "the account already exist"),
                                            );
                                          });
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text("Error"),
                                              content: Text(e.toString()),
                                            );
                                          });
                                    }
                                  }
                                },
                                icon: const Icon(Icons.add_circle_rounded),
                                label: const Text("Sign Up"),
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
