import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemeData{
  static Color primaryColor= Color(0xff5D9CEC);
  static Color primaryDarkColor= Color(0xff141922);
  static Color secondaryDarkColor= Color(0xff060E1E);
  static Color blackColor= Color(0xff363636);
  static Color whiteColor= Color(0xffFFFFFF);
  static Color lightBackground= Color(0xffDFECDB);
  static Color darkBackground= Color(0xff060E1E);
  static Color greenColor= Color(0xff61E757);



  static ThemeData lightTheme=ThemeData(
    scaffoldBackgroundColor: MyThemeData.lightBackground,
  appBarTheme: AppBarTheme(
    titleTextStyle: GoogleFonts.poppins(
      textStyle:TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color:MyThemeData.whiteColor
      ) ,
    ),
    backgroundColor: primaryColor
  ),
      textTheme: TextTheme(
    bodyLarge:GoogleFonts.poppins(
      textStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Color(0xffFFFFFF)
      )
    ),
        bodyMedium: GoogleFonts.poppins(
  textStyle: TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w700,
  color: MyThemeData.primaryColor
  )
        ),
        bodySmall: GoogleFonts.roboto(
  textStyle: TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  color: MyThemeData.blackColor
  )
        ),
        labelLarge: GoogleFonts.inter(
            textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: MyThemeData.blackColor
            )
        ),
  ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: Colors.transparent,
      selectedItemColor: MyThemeData.primaryColor,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: false,
      showSelectedLabels: false,

    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: Colors.white,
      padding: EdgeInsets.zero,
      shape: CircularNotchedRectangle(),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
  shape: OutlineInputBorder(
  borderRadius: BorderRadius.circular(35),
  borderSide: BorderSide(color: Colors.white,width: 4)
    ),
      backgroundColor: MyThemeData.primaryColor,
    ),
  );
  static ThemeData darkTheme=ThemeData(
    scaffoldBackgroundColor: MyThemeData.darkBackground,
    appBarTheme: AppBarTheme(
        titleTextStyle: GoogleFonts.poppins(
          textStyle:TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: MyThemeData.whiteColor
          ) ,
        ),
        backgroundColor: primaryColor
    ),
    textTheme: TextTheme(
      bodyLarge:GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xffFFFFFF)
          )
      ),
      bodyMedium: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: MyThemeData.primaryColor
          )
      ),
      bodySmall: GoogleFonts.roboto(
          textStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: MyThemeData.whiteColor
          )
      ),
      labelLarge: GoogleFonts.inter(
          textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: MyThemeData.whiteColor
          )
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: MyThemeData.primaryDarkColor,
      selectedItemColor: MyThemeData.primaryColor,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: false,
      showSelectedLabels: false,

    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: MyThemeData.primaryDarkColor,
      padding: EdgeInsets.zero,
      shape: CircularNotchedRectangle(),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: BorderSide(color: MyThemeData.primaryDarkColor,width: 4)
      ),
      backgroundColor: MyThemeData.primaryColor,
    ),
  );
}