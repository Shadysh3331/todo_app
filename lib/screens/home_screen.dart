import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/add_task_bottom_sheet.dart';
import 'package:todo_app/my_theme_data.dart';
import 'package:todo_app/provider/my_provider.dart';
import 'package:todo_app/tabs/settings.dart';
import 'package:todo_app/tabs/tasks.dart';

class HomeScreen extends StatefulWidget {
  static const String routName="home";
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text("Hello ${provider.userModel?.username}"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(onPressed: () {
        showModalBottomSheet(context: context,
          isScrollControlled: true,
          builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom
            ),
            child: AddTaskBottomSheet(),
          );
        },);
      },
        child: Icon(Icons.add,color: Colors.white,size: 35,),
      ),
      bottomNavigationBar:BottomAppBar(
        notchMargin: 8,
        child: BottomNavigationBar(
            iconSize: 30,
            currentIndex: selectedIndex,
            onTap: (index) {
              selectedIndex=index;
              setState(() {

              });
            },
            items: [
          BottomNavigationBarItem(icon: Icon(Icons.list),label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label: ""),
        ]),
      ) ,
      body: tabs[selectedIndex],
    );
  }
  List<Widget>tabs=[
    Tasks(),
    Settings()
  ];
}
