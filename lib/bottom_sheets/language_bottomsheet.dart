import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/my_theme_data.dart';

import '../provider/my_provider.dart';

class LanguageBottomsheet extends StatelessWidget {
  const LanguageBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                context.setLocale(Locale("ar"));
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "arabic".tr(),
                    style:context.locale==Locale("ar")? Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: provider.mode == ThemeMode.light
                            ? MyThemeData.primaryColor
                            : MyThemeData.primaryDarkColor):
                    Theme.of(context).textTheme.bodyLarge?.copyWith(color: MyThemeData.blackColor),
                  ),
                  context.locale == Locale("ar")
                      ? Icon(
                          Icons.done,
                          size: 30,
                          color: provider.mode == ThemeMode.light
                              ? MyThemeData.primaryColor
                              : MyThemeData.primaryDarkColor,
                        )
                      : SizedBox(),
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: () {
                context.setLocale(Locale("en"));
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "english".tr(),
                    style:context.locale==Locale("en")? Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: provider.mode == ThemeMode.light
                            ? MyThemeData.primaryColor
                            : MyThemeData.primaryDarkColor):
                    Theme.of(context).textTheme.bodyLarge?.copyWith(color: MyThemeData.blackColor),
                  ),
                  context.locale == Locale("en")
                      ? Icon(
                          Icons.done,
                          size: 30,
                          color: provider.mode == ThemeMode.light
                              ? MyThemeData.primaryColor
                              : MyThemeData.primaryDarkColor,
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
