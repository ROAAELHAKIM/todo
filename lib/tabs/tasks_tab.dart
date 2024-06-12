import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo/firebase_function.dart';
import 'package:todo/task_item.dart';
import 'package:todo/task_model.dart';

class TasksTab extends StatefulWidget {

   TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  var selectedDate=DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DatePicker(
          DateTime.now(),
          initialSelectedDate: selectedDate,
          selectionColor:Color(0xff7E57c2),
          height: 95,
          selectedTextColor: Colors.white,
          onDateChange: (date) {
            selectedDate=date;
            setState(() {

            });
          },
        ),
        SizedBox(
          height: 16,
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<TaskModel>>(
            stream: FirebaseFunctions.getTasks(selectedDate),
            builder: (context, snapshot) {

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Column(
                  children: [
                    Text("something went wrong"),
                    ElevatedButton(
                        onPressed: () {}, child: Text("Try Again Later"))
                  ],
                );
              }

              List<TaskModel> tasksList =
                  snapshot.data?.docs.map((doc) => doc.data()).toList() ?? [];

              if (tasksList.isEmpty){
                return Text("no tasks");
              }


              // return ListView.separated(
              //     itemBuilder: (context, index) {
              //       return TaskItem(model:tasksList[index]);
              //     },
              //     separatorBuilder: (context, index) => SizedBox(
              //           height: 12,
              //         ),
              //     itemCount: tasksList.length);

              return ListView.separated(
                  itemBuilder: (context, index) {
                    return TaskItem(model: tasksList[index],);
                  },
                  separatorBuilder: (context, index) => SizedBox(
                        height: 12,
                      ),
                  itemCount: tasksList.length);
            },
          ),
        ),
      ],
    );
  }
}
