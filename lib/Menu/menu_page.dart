import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn/Code%20QR/scanne_qr.dart';
import 'package:learn/Documentation/demande_doc.dart';
import 'package:learn/Equipements/gestion_inv.dart';
import 'package:learn/Intervenants/fichemetier.dart';
import 'package:learn/Interventions/GestionIntervention.dart';
import 'package:learn/PieceRech.dart/Article.dart';
import 'package:learn/Component/signin.dart';
import 'package:learn/TB/showgraphe.dart';


class MenuPage extends StatelessWidget {
  const MenuPage({super.key});



getUser() {
  var user = FirebaseAuth.instance.currentUser ;
  debugPrint(user!.email);
}
void initState() {
  getUser();
  newMethod();
}

newMethod() => initState();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page d'accueil"),
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.grey[300],

      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text(
                "Kachout Saif", style: TextStyle(fontWeight: FontWeight.bold),),
              accountEmail: Text("Kachoutsaif1@gmail.com"),
            ),
            InkWell(
              onTap: () {},
              child: const ListTile(
                leading: Icon(Icons.person),
                title: Text("PROFIL"),
              ),
            ),
            InkWell(
              onTap: () {},
              child: const ListTile(
                leading: Icon(Icons.settings),
                title: Text("SETTINGS"),
              ),
            ),
            InkWell(
              onTap: () {},
              child: const ListTile(
                leading: Icon(Icons.info),
                title: Text("ABOUT"),
              ),
            ),
            InkWell(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)
                   { return SignIn(); }));
              },
              child: const ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("LOGOUT"),
            ),
          ),
          ]
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: GridView.count(
          crossAxisCount: 2,
          children:  [
            MyMenu(title: "Gestion Des Equipements",
                onTap: (){ Navigator.of(context).push(MaterialPageRoute(builder: (context)
                { return const GestionInv(); }));},
                icon: Icons.file_present,
                col: Colors.brown),
            MyMenu(title: "Piece Des Rechanges",
                    onTap: (){ Navigator.of(context).push(MaterialPageRoute(builder: (context)
                    { return const Article(); }));},
                    icon: Icons.receipt_long_outlined,
                    col: Colors.deepPurple),
            MyMenu(title: "Gestion Des Interventions",
                onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)
                { return  const GestionIntervention(); }));},
                icon: Icons.account_tree_sharp,
                col: Colors.blue),
            MyMenu(title: "Exploitation Des Donneés et Statistique",
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)
                { return const TabBord(); }));
                },
                icon: Icons.leaderboard,
                col: Colors.orange),
            MyMenu(title: "Gestion Des Intervenants",
                onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)
                { return const FicheMetie(); }));},
                icon: Icons.account_box_rounded,
                col: Colors.blueGrey),
            MyMenu(title: "Documentation",
                onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)
                { return  const DemandeDoc(); }));},
                icon: Icons.inventory_outlined,
                col: Colors.red),
            MyMenu(title: "Scan QR",
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)
                { return  BarcodeScanner(); }));
                },
                icon: Icons.qr_code_2_outlined,
                col: Colors.teal),
          ],
        ),
      ),
    );
  }
}


class MyMenu extends StatelessWidget {
  const MyMenu ({super.key, required this.title ,  required this.icon ,  required this.col, required this.onTap});

  final String title;
  final IconData icon;
  final MaterialColor col;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return  Card(
          margin:  const EdgeInsets.all(8),
          child: InkWell(
            onTap: onTap,
            splashColor: Colors.grey,
            child: Center(
              child: Column (
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Icon(
                      icon,
                      size: 70,
                      color: col,
                  ),
                  Text(title, style: const TextStyle(fontSize: 15), textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        );
  }
}