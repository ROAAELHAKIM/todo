import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/firebase_function.dart';
import 'package:todo/task_model.dart';

class AddTaskBottomSheet extends StatefulWidget {
  static const String routeName = "AddTaskBottomSheet";

  AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var formKey=GlobalKey<FormState>();
  var selecteDate=DateTime.now();
  var descriptionController=TextEditingController();
  var titleController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key:formKey ,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Add New Task",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              validator: (value) {
                if(value==null|| value.isEmpty){
                  return"Please Enter Task Title ";
                }
                return null;
              },
              controller: titleController,
              decoration: InputDecoration(
                label: Text("title"),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(12)),
                enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              validator: (value) {
                if(value==null|| value.isEmpty){
                  return"Please Enter Task Description ";
                }
                return null;
              },
              controller: descriptionController,
              decoration: InputDecoration(
                label: Text("Description"),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(12)),
                enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Select Time",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                )),
            SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {
                selectDate(context);

              },
              child: Text(
                "${selecteDate.toString().substring(0,10)}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 16,
            ),

            Container(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    if(formKey.currentState!.validate()){
                      TaskModel task=TaskModel(
                          title: titleController.text,
                          userID: FirebaseAuth.instance.currentUser!.uid,
                          date: DateUtils.dateOnly(selecteDate).microsecondsSinceEpoch,
                          description: descriptionController.text);
                      FirebaseFunctions.addTask(task);
                        Navigator.pop(context);

                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xff7E57c2)),
                  child: Text(
                    "Add Task",
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                        color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }

  selectDate(BuildContext context) async{
    DateTime? chosenDate= await showDatePicker(

        context: context,
        initialDate: selecteDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate!=null){
      selecteDate=chosenDate;
      setState(() {

      });
    }

  }
}
