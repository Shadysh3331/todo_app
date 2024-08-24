import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/my_theme_data.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/provider/my_provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
   AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var titleController=TextEditingController();
  var descriptionController=TextEditingController();

  DateTime selectedDate=DateTime.now();
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return Container(
      color: provider.mode==ThemeMode.light?
      MyThemeData.whiteColor:
      MyThemeData.primaryDarkColor,
      padding: EdgeInsets.all(18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text("Add New Task",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: provider.mode==ThemeMode.light?
              Color(0xff383838):
                  MyThemeData.whiteColor
            ),
            ),
          ),
          SizedBox(
            height: 18,
          ),
          TextField(
            controller: titleController,
            style: TextStyle(color: provider.mode==ThemeMode.light?
            MyThemeData.blackColor:
            MyThemeData.whiteColor,),
            decoration: InputDecoration(
              hintText: "Title",
              hintStyle: TextStyle(color: provider.mode==ThemeMode.light?
              MyThemeData.blackColor:
              MyThemeData.whiteColor,),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18)
              )
            ),
          ),
          SizedBox(
            height: 18,
          ),
          TextField(
            controller: descriptionController,
            style: TextStyle(color: provider.mode==ThemeMode.light?
            MyThemeData.blackColor:
            MyThemeData.whiteColor,),
            decoration: InputDecoration(
                hintText: "Description",
                hintStyle: TextStyle(color: provider.mode==ThemeMode.light?
                MyThemeData.blackColor:
                MyThemeData.whiteColor,),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18)
                )
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Text("Select Date",style: Theme.of(context).textTheme.labelLarge,),
          SizedBox(
            height: 18,
          ),
          GestureDetector(
            onTap: () {
              chooseYourDate();
            },
            child: Center(
                child: Text(selectedDate.toString().substring(0,10),
                  style: Theme.of(context).textTheme.labelLarge,)),
          ),
          SizedBox(
            height: 18,
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(onPressed: () {
              TaskModel model=TaskModel(
                userId: FirebaseAuth.instance.currentUser?.uid?? "",
                  title: titleController.text,
                  description: descriptionController.text,
                  date: DateUtils.dateOnly(selectedDate).microsecondsSinceEpoch
              );
              FirebaseFunctions.addTask(model).then((value) {
                Navigator.pop(context);
              },);
            }, child: Text("Add",style: Theme.of(context).textTheme.bodyLarge,),
            style: ElevatedButton.styleFrom(
              backgroundColor: MyThemeData.primaryColor
            ),
            ),
          )
        ],
      ),
    );
  }

  chooseYourDate()async{
   DateTime? choosenDate= await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365))
    );
   if(choosenDate!=null){
     selectedDate=choosenDate;
     setState(() {

     });
   }
  }
}
