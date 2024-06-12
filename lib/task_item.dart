
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase_function.dart';
import 'package:todo/task_model.dart';

import 'add-task_bottom_sheet.dart';
import 'edit_task.dart';
import 'my_provider.dart';

class TaskItem extends StatelessWidget {


  TaskModel model;
   TaskItem({
     required this.model,
   super.key});


  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<MyProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Slidable(
        startActionPane:ActionPane(motion:DrawerMotion(),extentRatio: .5, children: [
          SlidableAction(onPressed: (context) {
            FirebaseFunctions().daleteTask(model.id);
          },
            icon: Icons.delete,
            backgroundColor: Colors.red,
            label: "Delete",
            borderRadius: BorderRadius.only(
                topLeft:Radius.circular(18),bottomLeft:Radius.circular(18) ),
          ),
          SlidableAction(onPressed: (context) {
            Navigator.push(context, PageTransition(
              type: PageTransitionType.rightToLeft,
              child: edit_task(taskModel: model),
            ));
            },
            icon: Icons.edit,
            backgroundColor: Color(0xff7E57c2),
            label: "Edit",
          ),
        ]) ,
        child: Row(

          children: [
            SizedBox(width: 16,),

            Container(
              height: 80,
              width: 4,
              margin: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                  color:model.isDone==true?Color(0xff9ccc65): Color(0xff7E57c2), borderRadius: BorderRadius.circular(25)),
            ),
            SizedBox(width: 16,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  model.title?? "",
                  //"title",
                  style: TextStyle(fontSize: 22,color:model.isDone==true?Color(0xff9ccc65): Color(0xff7E57c2)),
                ),
                Text(
                  model.description?? "",
                  //"description",
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
            Spacer(),
            // model.isDone?
            // Container(
            //     padding: EdgeInsets.symmetric(horizontal: 16,vertical: 2),
            //     decoration: BoxDecoration(
            //         color:Color(0xff9ccc65),
            //         borderRadius: BorderRadius.circular(12)),
            //     child: Text("Done!")
            // ):InkWell(onTap: () {
            //   if(model.isDone)return;
            //   model.isDone=true;
            //   FirebaseFunctions.editTask(model);
            //
            // },
            // child: Container(
            //     padding: EdgeInsets.symmetric(horizontal: 16,vertical: 2),
            //     decoration: BoxDecoration(color:Color(0xff7E57c2),borderRadius: BorderRadius.circular(12)),
            //     child: Icon(Icons.done,color: Colors.white,size: 30,)
            // ),
            // ),

            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: model.isDone==true?Color(0xff9ccc65): Color(0xff7E57c2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  model.isDone=!(model.isDone??false);

            }, child: model.isDone==true?Text("Done!"):Icon(Icons.check,color: Colors.white,))








          ],
        ),
      ),
    );
  }
}
