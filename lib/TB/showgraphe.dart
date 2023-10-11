import 'package:flutter/material.dart';
import 'package:learn/Menu/menu_page.dart';
import 'package:learn/TB/consulter.dart';
import 'package:learn/TB/consulter2.dart';
import 'package:learn/TB/consulter3.dart';
import 'package:learn/TB/consulter4.dart';
import 'package:learn/TB/consulter5.dart';

class TabBord extends StatelessWidget {
  const TabBord({super.key});

  @override
  Widget build(BuildContext context) {
     return  Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.blueGrey,
         title : const Text(
             "Visualisation Des Données ",
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
                    { return InterventionParUnite(); }));
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
                               "Intervention Total par Unité",
                               style: TextStyle(fontSize: 17,color: Colors.white),
                             ),
                           ),
                           const Icon(Icons.dashboard, size: 30.0)
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
                    { return  InterventionAnalytics(); }));
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
                               "Intervention Preventive par Unité",
                               style: TextStyle(fontSize: 17,color: Colors.white),
                             ),
                           ),
                           const Icon(Icons.dashboard, size: 30.0)
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
                    { return InterventionPrevData(); }));
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
                               "Intervention Preventive par Technicien",
                               style: TextStyle(fontSize: 17,color: Colors.white),
                             ),
                           ),
                           const Icon(Icons.dashboard, size: 30.0)
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
                    { return InterventionAnalyticsSelec(); }));
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
                                 "La repartion des Intervention par Moi",
                                 style:TextStyle(fontSize: 17,color: Colors.white)),
                           ),
                           const Icon(Icons.dashboard, size: 30.0)
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
                    { return CorrectiveInterventionAnalytics(); }));
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
                                 "Analyse des interventions correctives'",
                                 style:TextStyle(fontSize: 17,color: Colors.white)),
                           ),
                           const Icon(Icons.dashboard, size: 30.0)
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