import 'package:flutter/material.dart';

const primaryColor = Color(0xff082659);
const secondaryColor = Color(0xff51eec2);
final appTheme = ThemeData(
    textTheme:  TextTheme(
      bodyMedium: TextStyle(
        color: Colors.black.withOpacity(.8),
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      bodySmall: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      titleMedium: const TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18,),
      displaySmall: const TextStyle(
          fontWeight: FontWeight.bold, color: secondaryColor, fontSize: 12),
    ),
    appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
    buttonTheme: const ButtonThemeData(buttonColor: primaryColor),
    brightness: Brightness.light,
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
    ),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: primaryColor),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: secondaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
        floatingLabelStyle: const TextStyle(color: secondaryColor),
        labelStyle: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        iconColor: secondaryColor,
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: secondaryColor, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: secondaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
      outlineBorder: const BorderSide(color: secondaryColor),
      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 1.2))
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(primaryColor),
      textStyle: MaterialStatePropertyAll(TextStyle(color: Colors.white)),
      iconColor: MaterialStatePropertyAll(secondaryColor),
    )));
