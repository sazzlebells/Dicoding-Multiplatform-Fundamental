import 'package:flutter/material.dart';

final Map<int, Color> customPink = {
  50: const Color.fromRGBO(222, 113, 187, .1),
  100: const Color.fromRGBO(222, 113, 187, .2),
  200: const Color.fromRGBO(222, 113, 187, .3),
  300: const Color.fromRGBO(222, 113, 187, .4),
  400: const Color.fromRGBO(222, 113, 187, .5),
  500: const Color.fromRGBO(222, 113, 187, .6),
  600: const Color.fromRGBO(222, 113, 187, .7),
  700: const Color.fromRGBO(222, 113, 187, .8),
  800: const Color.fromRGBO(222, 113, 187, .9),
  900: const Color.fromRGBO(222, 113, 187, 1),
};

final Map<int, Color> customPurple = {
  50: const Color.fromRGBO(122, 68, 145, .1),
  100: const Color.fromRGBO(122, 68, 145, .2),
  200: const Color.fromRGBO(122, 68, 145, .3),
  300: const Color.fromRGBO(122, 68, 145, .4),
  400: const Color.fromRGBO(122, 68, 145, .5),
  500: const Color.fromRGBO(122, 68, 145, .6),
  600: const Color.fromRGBO(122, 68, 145, .7),
  700: const Color.fromRGBO(122, 68, 145, .8),
  800: const Color.fromRGBO(122, 68, 145, .9),
  900: const Color.fromRGBO(122, 68, 145, 1),
};

final MaterialColor primaryColor = MaterialColor(0xFFDE71BB, customPink);
final MaterialColor secondaryColor = MaterialColor(0xFF7A4491, customPurple);
Color cBackground = const Color.fromRGBO(221, 234, 243, 1);

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
