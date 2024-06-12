import 'package:flutter/material.dart';
import 'package:todo/firebase_function.dart';
import 'package:todo/task_model.dart';

class edit_task extends StatefulWidget {
  final TaskModel taskModel;

  edit_task({super.key, required this.taskModel});

  @override
  State<edit_task> createState() => _edit_taskState();
}

class _edit_taskState extends State<edit_task> {
  var descriptionController=TextEditingController();
  var titleController=TextEditingController();
  @override
  void initState() {
    super.initState();
    titleController.text=widget.taskModel.title;
    descriptionController.text=widget.taskModel.description;

  }
  var selecteDate=DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffDFECDB),

      appBar: AppBar(
        backgroundColor: Colors.deepPurple[400],
        title: Text("Edit Task",style: TextStyle(color: Colors.white),),
      ),
      body: Container(
        margin: EdgeInsets.all(30),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.white,
            borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          children: [

            TextFormField(
              onChanged: (value) {
                widget.taskModel.title=value;
              },
              controller: titleController,
              decoration: InputDecoration(
                label: Text("title"),
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
              onChanged: (value) {
                widget.taskModel.description=value;
              },
              controller: descriptionController,
              decoration: InputDecoration(
                label: Text("Description"),
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
              height: 20,
            ),

            ElevatedButton(
                onPressed: () async{
                await  FirebaseFunctions.editTask(widget.taskModel);
                Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xff7E57c2)),
                child: Text(
                  "Save Changes",
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 17,
                      color: Colors.white),
                )),


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
