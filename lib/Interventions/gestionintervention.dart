import 'package:flutter/material.dart';
import 'package:learn/Interventions/catlgintrv.dart';
import 'package:learn/Interventions/historique/ajout_his.dart';
import 'package:learn/Interventions/historique/consulter_hist.dart';
import 'package:learn/Interventions/planning.dart';
import 'package:learn/Menu/menu_page.dart';

class GestionIntervention extends StatelessWidget {
  const GestionIntervention({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
            "INTERVENTIONS",
            style: TextStyle(color: Colors.white)
        ),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return const MenuPage();
              }));
        }),
      ),

      body: Container(
        padding: const EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: () {
                   Navigator.of(context).push(
                   MaterialPageRoute(builder: (context) {
                       return const Cataloge();
              }));
                },
                child: Container(
                  height: 80.0,
                  width: 180.0,
                  decoration: BoxDecoration(boxShadow: const [
                    BoxShadow(
                        offset: Offset(0.0, 20.0),
                        blurRadius: 30.0,
                        color: Colors.black12)
                  ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22.0)),
                  child: Center(
                    child: Row(
                        children: <Widget>[
                          Container(
                            height: 80.0,
                            width: 140.0,
                            padding: const EdgeInsets.symmetric(vertical: 12.0,
                                horizontal: 12.0),
                            decoration: const BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(90.0),
                                    topLeft: Radius.circular(90.0),
                                    bottomRight: Radius.circular(300.0))),
                            child: const Center(
                              child: Text(
                                "Catalogue",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                          const Icon(Icons.mark_chat_read, size: 27.0)
                        ]
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            Center(
              child: InkWell(
                onTap: () {
                   Navigator.of(context).push(
                   MaterialPageRoute(builder: (context) {
                       return const ConsulterHist ();
              }));
                },
                child: Container(
                  height: 80.0,
                  width: 180.0,
                  decoration: BoxDecoration(boxShadow: const [
                    BoxShadow(
                        offset: Offset(0.0, 20.0),
                        blurRadius: 30.0,
                        color: Colors.black12)
                  ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22.0)),
                  child: Center(
                    child: Row(
                        children: <Widget>[
                          Container(
                            height: 80.0,
                            width: 140.0,
                            padding: const EdgeInsets.symmetric(vertical: 12.0,
                                horizontal: 12.0),
                            decoration: const BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(90.0),
                                    topLeft: Radius.circular(90.0),
                                    bottomRight: Radius.circular(300.0))),
                            child: const Center(
                              child: Text(
                                "Historique",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                          const Icon(Icons.history_outlined, size: 27.0)
                        ]
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            Center(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                   MaterialPageRoute(builder: (context) {
                       return const  Planning();
              }));
                },
                child: Container(
                  height: 80.0,
                  width: 180.0,
                  decoration: BoxDecoration(boxShadow: const [
                    BoxShadow(
                        offset: Offset(0.0, 20.0),
                        blurRadius: 30.0,
                        color: Colors.black12)
                  ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22.0)),
                  child: Center(
                    child: Row(
                        children: <Widget>[
                          Container(
                            height: 80.0,
                            width: 140.0,
                            padding: const EdgeInsets.symmetric(vertical: 12.0,
                                horizontal: 12.0),
                            decoration: const BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(90.0),
                                    topLeft: Radius.circular(90.0),
                                    bottomRight: Radius.circular(300.0))),
                              child: const Center(
                                child: Text(
                                    "Planning",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)),
                              ),
                            ),
                          const Icon(Icons.work, size: 27.0)
                        ]
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}