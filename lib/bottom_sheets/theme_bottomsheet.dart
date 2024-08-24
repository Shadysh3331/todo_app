import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/my_provider.dart';

import '../my_theme_data.dart';

class ThemeBottomsheet extends StatelessWidget {
  const ThemeBottomsheet({super.key});

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
                provider.changeTheme(ThemeMode.light);
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "light".tr(),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: provider.mode == ThemeMode.light
                            ? MyThemeData.primaryColor
                            : MyThemeData.primaryDarkColor),
                  ),
                  provider.mode == ThemeMode.light
                      ? Icon(
                    Icons.done,
                    size: 30,
                    color: MyThemeData.primaryColor,
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
                provider.changeTheme(ThemeMode.dark);
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "dark".tr(),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: provider.mode == ThemeMode.dark
                            ? MyThemeData.primaryColor
                            : MyThemeData.primaryDarkColor),
                  ),
                  provider.mode == ThemeMode.dark
                      ? Icon(
                    Icons.done,
                    size: 30,
                    color: MyThemeData.primaryColor,
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
