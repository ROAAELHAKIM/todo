import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo/firebase_function.dart';
import 'package:todo/user_model.dart';

class MyProvider extends ChangeNotifier {
  UserModel? userModel;
  User? firebaseUser;

  MyProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initUser();
    }
  }

  initUser() async {
    userModel = await FirebaseFunctions.readUser();
    notifyListeners();

  }
  logout(){
    FirebaseAuth.instance.signOut();
    userModel=null;
    firebaseUser=null;
    notifyListeners();
  }
}
