import 'dart:async';

import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'login/auth.dart';

class splashScreen extends StatefulWidget {
  static const String routeName="splashScreen";

  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds:3), () {
      Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffDFECDB),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

          Container(
            width: double.infinity,
            child: Image(image: AssetImage("assets/images/logo.png")),)
        ],),
      ),

    );
  }
}
