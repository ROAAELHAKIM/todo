import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/task_model.dart';
import 'package:todo/user_model.dart';

class FirebaseFunctions {
 static CollectionReference<TaskModel> getTasksCollection(){
    return FirebaseFirestore
        .instance.collection('Tasks').withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromjson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.tojson();
      },
    );
}

 static CollectionReference<UserModel> getUsersCollection(){
   return FirebaseFirestore
       .instance.collection('Users').withConverter<UserModel>(
     fromFirestore: (snapshot, _) {
       return UserModel.fromjson(snapshot.data()!);
     },
     toFirestore: (value, _) {
       return value.tojson();
     },
   );
 }

 static Future<UserModel?> readUser()async{
String id =FirebaseAuth.instance.currentUser!.uid;
DocumentSnapshot<UserModel> snap= await getUsersCollection().doc(id).get();
return  snap.data();
 }

static Future<void>addUser(UserModel userModel){
  var collection=getUsersCollection();
  var docref=collection.doc(userModel.id);
 return  docref.set(userModel);
}




 static Future<void> addTask(TaskModel task) {
    var collection=getTasksCollection();
    var docref=collection.doc();
    task.id=docref.id;
    return docref.set(task);

    // .add(TaskModel(title: "title",
    //     date: 12020200, description: "description"));
  }

   static Future<void> editTask(TaskModel taskModel)async {
    await getTasksCollection().doc(taskModel.id).update(taskModel.tojson());
 }


 static Stream<QuerySnapshot<TaskModel>> getTasks(DateTime date){
   return getTasksCollection()
   .where("userID",isEqualTo: FirebaseAuth.instance.currentUser!.uid)
       .where("date",isEqualTo: DateUtils.dateOnly(date).microsecondsSinceEpoch)
       .snapshots();
  }
  Future<void> daleteTask(String id){
   return getTasksCollection().doc(id).delete();
  }

   static createAccount(
       {required String email,
         required String password,
         required String phone,
         required String username,
         required Function onSuccess,
         required Function onError})async{
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      credential.user!.sendEmailVerification();
      UserModel userModel=UserModel(
        email: email,
        phone: phone,
        id: credential.user!.uid,
        username: username
      );
      addUser(userModel);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError(e.message);
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        onError(e.message);

        print('The account already exists for that email.');
      }
      onError(e.message);

    } catch (e) {
      print(e);
      onError(e.toString());

    }
  }

  static login(String email,String password, Function onSuccess, Function onError)async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      // if(credential.user!.emailVerified){
        onSuccess();
      // }else{
      //   onError("plese verify your account");
      // }
    } on FirebaseAuthException catch (e) {
      onError(e.message);

    }
  }
}
