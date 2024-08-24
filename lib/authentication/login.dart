import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/authentication/signup.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/provider/my_provider.dart';

import '../my_theme_data.dart';

class LoginScreen extends StatelessWidget {
  static const String routName="login";
   LoginScreen({Key? key}) : super(key: key);

  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               TextField(
                controller:emailController ,
                style: TextStyle(color: provider.mode==ThemeMode.light?
                MyThemeData.blackColor:
                MyThemeData.whiteColor,),
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 16),
               TextField(
                controller: passwordController,
                style: TextStyle(color: provider.mode==ThemeMode.light?
                MyThemeData.blackColor:
                MyThemeData.whiteColor,),
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  FirebaseFunctions.loginUser(emailController.text, passwordController.text,
                      onSuccess: (){
                      provider.initUser();
                      Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routName, (route) => false,);
                      }, onError: (error){
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
                child: const Text('Login'),
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
            Text("Don't have an account?",style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 16
            ),),
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, SignupScreen.routName);
                },
                child: Text("SignUp")),
          ],
        ),
      ),
    );
  }
}
