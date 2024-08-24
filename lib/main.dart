import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/authentication/login.dart';
import 'package:todo_app/authentication/signup.dart';
import 'package:todo_app/screens/edit_screen.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/my_theme_data.dart';
import 'package:todo_app/provider/my_provider.dart';

import 'firebase_options.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (context) => MyProvider(),
      child: EasyLocalization(
          supportedLocales: [Locale('en'), Locale('ar')],
          saveLocale: true,
          path: 'assets/translations', // <-- change the path of the translation files
          child: MyApp())));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context)..getTheme();
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      themeMode: provider.mode,
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      initialRoute: provider.firebaseUser != null ? HomeScreen.routName : LoginScreen.routName,
      routes: {
        HomeScreen.routName: (context)=> HomeScreen(),
        LoginScreen.routName: (context)=> LoginScreen(),
        SignupScreen.routName: (context)=> SignupScreen(),
        EditScreen.routName: (context)=> EditScreen(),
      },
    );
  }
}
