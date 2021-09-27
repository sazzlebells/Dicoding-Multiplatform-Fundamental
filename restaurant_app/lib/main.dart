import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/detail.dart';
import 'package:restaurant_app/home.dart';
import 'package:restaurant_app/restaurant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wisata Kuliner Lampung',
      theme: ThemeData(
        primarySwatch: primaryColor,
        accentColor: secondaryColor,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: myTextTheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: secondaryColor,
            textStyle: myTextTheme.button,
          ),
        ),
      ),
      initialRoute: MyHomePage.routeName,
      routes: {
        MyHomePage.routeName: (context) => MyHomePage(),
        DetailPage.routeName: (context) => DetailPage(
            detail: ModalRoute.of(context)?.settings.arguments as Restaurant),
      },
    );
  }
}
