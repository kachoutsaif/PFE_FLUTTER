import 'package:flutter/material.dart';
import 'package:learn/Documentation/analyse_panne.dart';
import 'package:learn/Documentation/dem_achat.dart';
import 'package:learn/Documentation/dem_inter.dart';
import 'package:learn/Documentation/rapport_interv.dart';
import 'package:learn/Menu/menu_page.dart';

class DemandeDoc extends StatelessWidget {
  const DemandeDoc({super.key});

  @override
  Widget build(BuildContext context) {
     return  Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.blueGrey,
         title : const Text(
             "DOCUMENTAIRE",
             style: TextStyle(color: Colors.white)
         ),
         leading: IconButton(icon: const Icon(Icons.arrow_back),onPressed: (){
           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)
           { return const MenuPage(); }));
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
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)
                    { return const DemInter(); }));
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
                             child:  const Text(
                               "Demande Intervention",
                               style: TextStyle(fontSize: 17,color: Colors.white),
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
                   Navigator.of(context).push(MaterialPageRoute(builder: (context)
                    { return const Achat(); }));
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
                             child:  const Text(
                               "Demande D'achats",
                               style: TextStyle(fontSize: 17,color: Colors.white),
                             ),
                           ),
                           const Icon(Icons.sell, size: 27.0)
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
                   Navigator.of(context).push(MaterialPageRoute(builder: (context)
                    { return const Rapport(); }));
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
                             child:  const Text(
                               "Rapport D'intervention",
                               style: TextStyle(fontSize: 17,color: Colors.white),
                             ),
                           ),
                           const Icon(Icons.filter_frames_sharp, size: 27.0)
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
                    { return const Analyse(); }));
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
                             child:  const Text(
                                 "Analyse de Panne",
                                 style:TextStyle(fontSize: 17,color: Colors.white)),
                           ),
                           const Icon(Icons.build, size: 27.0)
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