import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/models/user_model.dart';

class MyProvider extends ChangeNotifier {
  ThemeMode mode=ThemeMode.light;
  User? firebaseUser;
  UserModel? userModel;

  MyProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initUser();
    }
  }

  Future<void> initUser() async {
    if (firebaseUser != null) {
      userModel = await FirebaseFunctions.readUser();
      notifyListeners();
    }
  }
  getTheme()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isDark=prefs.getBool('isDark');
    if(isDark!=null){
      if(isDark==true){
        mode=ThemeMode.dark;
      }else{
        mode=ThemeMode.light;
      }
      notifyListeners();
    }

  }
  changeTheme(ThemeMode themeMode)async{
    mode=themeMode;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', mode==ThemeMode.dark);
    notifyListeners();
  }
}
