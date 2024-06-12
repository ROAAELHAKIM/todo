import 'package:flutter/material.dart';
import 'package:todo/login/Register.dart';
import 'package:todo/login/login.dart';

class AuthScreen extends StatelessWidget {
  static const String routeName="Auth";
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Text("Login")),
              Tab(icon: Text("Register")),
            ],
          ),
          title: Text('ToDO'),
        ),
        body: TabBarView(
          children: [
           LoginTab(),
            RegisterTab(),
          ],
        ),
      ),
    );
  }
}
