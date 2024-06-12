//import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/home_screen.dart';
import 'package:todo/my_provider.dart';
import 'package:todo/splash_screen.dart';

import 'add-task_bottom_sheet.dart';
import 'firebase_options.dart';
import 'login/auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 // await FirebaseFirestore.instance.disableNetwork();
  runApp(ChangeNotifierProvider(
      create: (context)=>MyProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<MyProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:splashScreen.routeName,
      routes: {
        splashScreen.routeName: (context) => splashScreen(),
        AuthScreen.routeName: (context) => provider.firebaseUser !=null
         ?HomeScreen()
        : AuthScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        AddTaskBottomSheet.routeName: (context) => AddTaskBottomSheet(),

      },
    );
  }
}


