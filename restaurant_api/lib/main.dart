import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/common/color.dart';
import 'package:restaurant_api/common/style.dart';
import 'package:restaurant_api/data/api/api_service.dart';
import 'package:restaurant_api/data/db/database_helper.dart';
import 'package:restaurant_api/data/model/restaurant.dart';
import 'package:restaurant_api/provider/database_provider.dart';
import 'package:restaurant_api/provider/restaurant_provider.dart';
import 'package:restaurant_api/ui/detail_page.dart';
import 'package:restaurant_api/ui/favorite_page.dart';
import 'package:restaurant_api/ui/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => DatabaseProvider(dbHelper: DatabaseHelper())),
        ChangeNotifierProvider<RestaurantProvider>(
          create: (_) => RestaurantProvider(service: ApiService()),
        ),
      ],
      child: _materialApp(),
    );
  }

  MaterialApp _materialApp() {
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
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        DetailPage.routeName: (context) => DetailPage(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant,
              // isFavorite: ModalRoute.of(context)?.settings.arguments as bool,
            ),
        FavoritePage.routeName: (context) => const FavoritePage(),
      },
    );
  }
}
