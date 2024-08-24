import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/authentication/login.dart';
import 'package:todo_app/bottom_sheets/language_bottomsheet.dart';
import 'package:todo_app/bottom_sheets/theme_bottomsheet.dart';
import 'package:todo_app/my_theme_data.dart';

import '../provider/my_provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    String themeText = provider.mode == ThemeMode.light ? "light".tr() : "dark".tr();
    String languageText = context.locale == Locale("ar") ? "arabic".tr() : "english".tr();
    return Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("language".tr(),style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: provider.mode==ThemeMode.light?
                  MyThemeData.blackColor:
                  MyThemeData.whiteColor
            ),
            ),
            SizedBox(height: 24,),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  isDismissible: true,
                  backgroundColor: Colors.white,
                  context: context, builder: (context) {
                  return LanguageBottomsheet();
                },
                );
              },
              child: Container(
                padding: EdgeInsets.all(12),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: MyThemeData.primaryColor)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(languageText),
                    Icon(Icons.expand_more,
                      color: MyThemeData.primaryColor,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24,),
            Text("theme".tr(),style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: provider.mode==ThemeMode.light?
                MyThemeData.blackColor:
                MyThemeData.whiteColor
            ),
            ),
            SizedBox(height: 24,),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  isDismissible: true,
                  backgroundColor: Colors.white,
                  context: context, builder: (context) {
                  return ThemeBottomsheet();
                },
                );
              },
              child: Container(
                padding: EdgeInsets.all(12),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: MyThemeData.primaryColor)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(themeText),
                    Icon(Icons.expand_more,
                      color: MyThemeData.primaryColor,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Center(
              child: ElevatedButton(onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routName,(route) => false,);
              }, child: Text("Logout")),
            )
          ],
        ),
      );
  }
}
