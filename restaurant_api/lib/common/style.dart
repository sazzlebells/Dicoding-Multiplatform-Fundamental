import 'package:flutter/material.dart';
import 'package:restaurant_api/common/color.dart';

TextTheme myTextTheme = const TextTheme(
  headline1: TextStyle(
      fontSize: 92,
      fontWeight: FontWeight.w300,
      fontFamily: "Lato",
      letterSpacing: -1.5),
  headline2: TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.w300,
      fontFamily: "Lato",
      letterSpacing: -0.5),
  headline3:
      TextStyle(fontSize: 46, fontWeight: FontWeight.w300, fontFamily: "Lato"),
  headline4: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      fontFamily: "Lato",
      letterSpacing: 0.25),
  headline5:
      TextStyle(fontSize: 23, fontWeight: FontWeight.w400, fontFamily: "Lato"),
  headline6: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w700,
      fontFamily: "Lato",
      letterSpacing: 0.15),
  subtitle1: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      fontFamily: "Lato",
      letterSpacing: 0.15),
  subtitle2: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w700,
      fontFamily: "Lato",
      letterSpacing: 0.1),
  bodyText1: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontFamily: "Lato",
      letterSpacing: 0.5),
  bodyText2: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      fontFamily: "Lato",
      letterSpacing: 0.25),
  button: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      fontFamily: "Lato",
      letterSpacing: 1.25),
  caption: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w300,
      fontFamily: "Lato",
      letterSpacing: 0.4),
  overline: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w300,
      fontFamily: "Lato",
      letterSpacing: 1.5),
);

ThemeData lightTheme = ThemeData(
  primarySwatch: primaryColor,
  accentColor: secondaryColor,
  scaffoldBackgroundColor: Colors.white,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: myTextTheme,
  appBarTheme:
      AppBarTheme(textTheme: myTextTheme.apply(bodyColor: primaryColor)),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: secondaryColor,
      textStyle: myTextTheme.button,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  primarySwatch: darkPrimaryColor,
  accentColor: darkSecondaryColor,
  scaffoldBackgroundColor: Colors.white,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: myTextTheme,
  appBarTheme:
      AppBarTheme(textTheme: myTextTheme.apply(bodyColor: darkPrimaryColor)),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: darkSecondaryColor,
      textStyle: myTextTheme.button,
    ),
  ),
);
