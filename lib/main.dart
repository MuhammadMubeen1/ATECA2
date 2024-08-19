import 'dart:ffi';
import 'package:employe_portal/firebase_options.dart';
import 'package:employe_portal/view/admin/create_employee.dart';
import 'package:employe_portal/view/admin/login_screen.dart';

import 'package:employe_portal/view/admin/users_screen.dart';
import 'package:employe_portal/widgetss/spl.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:employe_portal/controllor/login_controllor.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      
        debugShowCheckedModeBanner: false,
        home:
            //ogin_Screen()
            // aUsers(),
            SplashScreen()
        // Login_Screen()

        );
  }

  Future<String?> getCurrentUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }
}
