import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/screens/home_screen.dart';

import '../my_theme_data.dart';
import '../provider/my_provider.dart';

class EditScreen extends StatefulWidget {
  static const String routName = "edit";

  EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var model = ModalRoute.of(context)?.settings.arguments as TaskModel;
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do List"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          height: MediaQuery.of(context).size.height * .9,
          child: Card(
            color: provider.mode==ThemeMode.light?
            Colors.white:
            MyThemeData.primaryDarkColor,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Edit Task",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: provider.mode == ThemeMode.light
                                ? Color(0xff383838)
                                : MyThemeData.whiteColor),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      initialValue: model.title,
                      onChanged: (value) {
                        model.title = value;
                      },
                      style: TextStyle(
                        color: provider.mode == ThemeMode.light
                            ? MyThemeData.blackColor
                            : MyThemeData.whiteColor,
                      ),
                      decoration: InputDecoration(
                          hintText: "Title",
                          hintStyle: TextStyle(
                            color: provider.mode == ThemeMode.light
                                ? MyThemeData.blackColor
                                : MyThemeData.whiteColor,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18))),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      initialValue: model.description,
                      onChanged: (value) {
                        model.description = value;
                      },
                      style: TextStyle(
                        color: provider.mode == ThemeMode.light
                            ? MyThemeData.blackColor
                            : MyThemeData.whiteColor,
                      ),
                      decoration: InputDecoration(
                          hintText: "Description",
                          hintStyle: TextStyle(
                            color: provider.mode == ThemeMode.light
                                ? MyThemeData.blackColor
                                : MyThemeData.whiteColor,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18))),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Select Date",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    InkWell(
                      onTap: () async {
                        DateTime? newDate = await chooseYourDate();
                        if (newDate != null) {
                          model.date = newDate.millisecondsSinceEpoch;
                          setState(() {

                          });
                        }
                      },
                      child: Center(
                        child: Text(
                            DateFormat.yMd().format(
                              DateUtils.dateOnly(
                                DateTime.fromMillisecondsSinceEpoch(model.date ?? 0),
                              ),
                            ),
                            style: Theme.of(context).textTheme.labelLarge
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 60, vertical: 15),
                              backgroundColor: MyThemeData.primaryColor,
                              foregroundColor: Colors.white,
                              textStyle: Theme.of(context).textTheme.bodyLarge),
                          onPressed: () async {
                            await FirebaseFunctions.updateTask(model);
                            Navigator.pop(context);
                          },
                          child: Text("Save Changes")),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  chooseYourDate() async {
    DateTime? chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate != null) {
      selectedDate = chosenDate;
      setState(() {});
    }
    return chosenDate;
  }
}