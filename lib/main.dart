import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learn/Component/signin.dart';
import 'package:learn/Equipements/informach.dart';
import 'package:learn/Interventions/modoles/db_helper.dart';
import 'package:learn/Interventions/notification_sevices.dart';
import 'package:learn/Interventions/theme.dart';
import 'package:learn/Interventions/theme_sevices.dart';
import 'firebase_options.dart';

late bool islogin;
Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    islogin = false;
  } else {
    islogin = true;
  }
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme:Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      home: SignIn(),
      builder: (context, child) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: child,
        );
      },
    );
  }
}
