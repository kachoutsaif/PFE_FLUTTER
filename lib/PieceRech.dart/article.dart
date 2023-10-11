import 'package:flutter/material.dart';
import 'package:learn/Menu/menu_page.dart';
import 'package:learn/PieceRech.dart/articl/consult_art.dart';
import 'package:learn/PieceRech.dart/fournisseur/consult_four.dart';

class Article extends StatelessWidget {
  const Article({super.key});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title : const Text(
            "Article",
            style: TextStyle(color: Colors.white)
        ),
        leading: IconButton(icon: const Icon(Icons.arrow_back),onPressed: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)
          { return const MenuPage(); }));
        }),
      ),

      body: Container(
        padding: const EdgeInsets.all(100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)
                  { return  const ConsulterArt(); }));
                },
                child: Container(
                  height: 80.0,
                  width: 180.0,
                  decoration:  BoxDecoration(boxShadow: const [
                    BoxShadow(
                        offset: Offset(0.0,20.0),
                        blurRadius: 30.0,
                        color:  Colors.black12)
                  ], color: Colors.white , borderRadius: BorderRadius.circular(22.0)),
                  child : Center(
                    child: Row(
                        children: <Widget>[
                          Container(
                            height: 80.0,
                            width: 140.0,
                            padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 12.0),
                            decoration: const BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(90.0),
                                    topLeft: Radius.circular(90.0),
                                    bottomRight: Radius.circular(300.0))),
                            child:  const Center(
                              child: Text(
                                "Fiche           Article",
                                style: TextStyle(fontSize: 17,color: Colors.white),
                              ),
                            ),
                          ),
                          const Icon(Icons.article_outlined, size: 29.0)
                        ]
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)
                  { return const ConsulterFourn(); }));
                },
                child: Container(
                  height: 80.0,
                  width: 180.0,
                  decoration:  BoxDecoration(boxShadow: const [
                    BoxShadow(
                        offset: Offset(0.0,20.0),
                        blurRadius: 30.0,
                        color:  Colors.black12)
                  ], color: Colors.white , borderRadius: BorderRadius.circular(22.0)),
                  child : Center(
                    child: Row(
                        children: <Widget>[
                          Container(
                            height: 80.0,
                            width: 140.0,
                            padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 12.0),
                            decoration: const BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(90.0),
                                    topLeft: Radius.circular(90.0),
                                    bottomRight: Radius.circular(300.0))),
                            child:  const Center(
                              child: Text(
                                  "Fiche Fournisseur",
                                  style:TextStyle(fontSize: 17,color: Colors.white)),
                            ),
                          ),
                          const Icon(Icons.keyboard_command_key_outlined, size: 29.0)
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