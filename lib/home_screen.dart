import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/tabs/setting_tab.dart';
import 'package:todo/tabs/tasks_tab.dart';

import 'add-task_bottom_sheet.dart';
import 'login/auth.dart';
import 'my_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<MyProvider>(context);

    return Scaffold(
      extendBody: true,
      backgroundColor: Color(0xffDFECDB),
     // backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        actions: [IconButton(onPressed: (){
          provider.logout();
           Navigator.pushNamedAndRemoveUntil(context, AuthScreen.routeName, (route) => false);
        }, icon: Icon(Icons.logout,color: Colors.white,))],
        backgroundColor: Colors.deepPurple[400],
        title: Text(
          "ToDo ${provider.userModel?.username}",
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(context: context,
            isScrollControlled: true,
            builder:  (context) {
            return Container(
                padding: EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom)
                ,
                child: AddTaskBottomSheet());
          },);
        },
        backgroundColor: Colors.deepPurple[400],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),side: BorderSide(color: Colors.white,width:3  )),
        child: Icon(Icons.add,color: Colors.white,size: 30,),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        padding: EdgeInsets.zero,
        height: 60,
        notchMargin: 8,
        child: BottomNavigationBar(
            currentIndex: index,
            onTap: (value) {
              index = value;
              setState(() {});
            },
            backgroundColor: Colors.transparent,
            elevation: 0,
            unselectedItemColor: Color(0xffC8C9CB),
            selectedItemColor: Colors.deepPurple[400],
            showUnselectedLabels: false,
            showSelectedLabels: false,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.list), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
            ]),
      ),
      body:tabs[index] ,
    );
  }
  List<Widget>tabs=[
    TasksTab(),
    settingTab(),
  ];
}
