import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/authentication/login.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/provider/my_provider.dart';

import '../my_theme_data.dart';

class SignupScreen extends StatelessWidget {
  static const String routName="signup";
   SignupScreen({Key? key}) : super(key: key);

  var emailController=TextEditingController();
  var ageController=TextEditingController();
  var phoneController=TextEditingController();
  var passwordController=TextEditingController();
  var usernameController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Sign Up Screen'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               TextField(
                 style: TextStyle(color: provider.mode==ThemeMode.light?
                 MyThemeData.blackColor:
                 MyThemeData.whiteColor,),
                 controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                style: TextStyle(color: provider.mode==ThemeMode.light?
                MyThemeData.blackColor:
                MyThemeData.whiteColor,),
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                style: TextStyle(color: provider.mode==ThemeMode.light?
                MyThemeData.blackColor:
                MyThemeData.whiteColor,),
                controller: phoneController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Phone',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                style: TextStyle(color: provider.mode==ThemeMode.light?
                MyThemeData.blackColor:
                MyThemeData.whiteColor,),
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Age',
                ),
              ),
              const SizedBox(height: 16),
               TextField(
                 style: TextStyle(color: provider.mode==ThemeMode.light?
                 MyThemeData.blackColor:
                 MyThemeData.whiteColor,),
                 controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  FirebaseFunctions.createAccountAuth(
                      emailController.text,
                      passwordController.text,
                      age: int.parse(ageController.text),
                      phone: phoneController.text,
                      username: usernameController.text,
                  onSuccess: (){
                    Navigator.pushNamed(context, LoginScreen.routName);
                  },
                    onError: (error){
                      showDialog(context: context, builder: (context) => AlertDialog(
                        title: Text("Error"),
                        content: Text(error),
                        actions: [
                          ElevatedButton(onPressed: () {
                            Navigator.pop(context);
                          }, child: Text("Ok"))
                        ],
                      ),);
                    }
                  );
                },
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("I have an account?",style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 16
            ),),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text("Login")),
          ],
        ),
      ),
    );
  }
}
