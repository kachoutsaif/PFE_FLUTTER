
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:learn/Interventions/notifyed_page.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'modoles/task.dart';

class NotifyHelper {
 FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initializeNotification() async {
    tz.initializeTimeZones();
   final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@drawable/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(
       android: initializationSettingsAndroid
    );
    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: selectNotification);
  }
    Future<void> displayNotification(
          {required String title, required String body}) async {
        var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
            'your channel id', 'your channel name', 
            importance: Importance.max, priority: Priority.high);
        var platformChannelSpecifics = NotificationDetails(
          android: androidPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(
          0,
          title,
          body,
          platformChannelSpecifics,
          payload: title,
        );
      }

       scheduledNotification() async {
        await flutterLocalNotificationsPlugin.zonedSchedule(
         0,
         'scheduled title',
         'theme changes 5 seconds ago',
         tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
         const NotificationDetails(
             android: AndroidNotificationDetails('your channel id',
                 'your channel name',)),
         androidAllowWhileIdle: true,
         uiLocalNotificationDateInterpretation:
             UILocalNotificationDateInterpretation.absoluteTime);
       }
    }


  Future selectNotification(NotificationResponse n) async {
    if (n.payload != null) {
      print('notification payload: ${n.payload}');
    } else {
      print("Notification Done");
    }
    if (n.payload == "Theme Changed") {
    } else {
      Get.to(() => NotifiedPage(label: n.payload));
    }


  // Future onDidReceiveLocalNotification()
  //     int id, String title, String body, String? payload) async {
  //   // display a dialog with the notification details, tap ok to go to another page
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) => CupertinoAlertDialog(
  //       title: Text(title),
  //       content: Text(body),
  //       actions: [
  //         CupertinoDialogAction(
  //           isDefaultAction: true,
  //           child: const Text('Ok'),
  //           onPressed: () async {
  //             Navigator.of(context, rootNavigator: true).pop();
  //             await Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => SecondScreen(payload),
  //               ),
  //             );
  //           },
  //         )
  //       ],
  //     ), 
  //   );
  //   Get.dialog(const Text("welcome to nitificaion"));
  // }
  }
  



  

      

  

    

  

