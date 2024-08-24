import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/my_theme_data.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/provider/my_provider.dart';
import 'package:todo_app/screens/edit_screen.dart';

class TaskItem extends StatelessWidget {
  TaskModel model;
   TaskItem({super.key,required this.model});

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: provider.mode==ThemeMode.light?
            MyThemeData.whiteColor:
            MyThemeData.primaryDarkColor,
      ),
      // padding: EdgeInsets.all(18),
      margin: EdgeInsets.all(18),
      child: Slidable(
        startActionPane: ActionPane(
            extentRatio: .6,
            motion: DrawerMotion(), children: [
          SlidableAction(onPressed: (context) {
            FirebaseFunctions.deleteTask(model.id);
          },
          backgroundColor: Colors.red,
            icon: Icons.delete,
            label: "Delete",
            borderRadius: BorderRadius.only(
              bottomLeft:Radius.circular(18) ,
              topLeft: Radius.circular(18),
            ),
          ),
          SlidableAction(onPressed: (context) {
            Navigator.pushNamed(context, EditScreen.routName,
            arguments: model
            );
          },
            backgroundColor: Colors.blue,
            icon: Icons.edit,
            label: "Edit",
          ),
        ]
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 90,
                width: 2,
                color: model.isDone? MyThemeData.greenColor:MyThemeData.primaryColor,
              ),
              SizedBox(width: 12,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(model.title,style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: model.isDone ? MyThemeData.greenColor:MyThemeData.primaryColor
                    ),),
                    Text(model.description,style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
             model.isDone ? Text("Done!",style: Theme.of(context).textTheme.bodyLarge?.copyWith(
               color: MyThemeData.greenColor
             ),): IconButton(onPressed: () {
                model.isDone=true;
                FirebaseFunctions.updateTask(model);
              }, icon: Icon(Icons.done,size: 30,),
              color: Colors.white,
                style:ElevatedButton.styleFrom(
                  backgroundColor: MyThemeData.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                  ),
                  minimumSize: Size(80, 40)
                ) ,
                padding: EdgeInsets.zero,
              )
            ],
          ),
        ),
      ),
    );
  }
}
