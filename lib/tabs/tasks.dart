import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/provider/my_provider.dart';

import '../my_theme_data.dart';
import '../task_item.dart';

class Tasks extends StatefulWidget {
   Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
   DateTime dateTime=DateTime.now();

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return Column(
      children: [
        CalendarTimeline(
          initialDate: dateTime,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) {
            dateTime=date;
            setState(() {

            });
          },
          leftMargin: 20,
          monthColor:provider.mode==ThemeMode.light?
          MyThemeData.blackColor:
          MyThemeData.whiteColor,
          dayColor:provider.mode==ThemeMode.light?
          MyThemeData.primaryColor:
          MyThemeData.whiteColor,
          activeDayColor: provider.mode==ThemeMode.light?
          MyThemeData.whiteColor:
          MyThemeData.whiteColor,
          activeBackgroundDayColor:provider.mode==ThemeMode.light?
          MyThemeData.primaryColor:
          MyThemeData.blackColor,
          selectableDayPredicate: (date) => date.day != 23,
          locale: 'en_ISO',
        ),
        Expanded(
          child: StreamBuilder(
            stream:FirebaseFunctions.getTask(dateTime),
            builder: (context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }
              if(snapshot.hasError){
                return Column(
                  children: [
                    Text("Something went wrong"),
                    ElevatedButton(onPressed: () {}, child: Text("Try again"))
                  ],
                );
              }
              var tasks=snapshot.data?.docs.map((e) => e.data()).toList();
              if(tasks?.isEmpty?? true){
                return Text("No Tasks");
              }
             return ListView.builder(
                itemBuilder: (context, index) {
                  return TaskItem(model: tasks[index],);
                },
                itemCount: tasks!.length,
              );
            },
          ),
        ),
      ],
    );
  }
}
