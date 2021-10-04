import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/common/color.dart';
import 'package:restaurant_api/common/navigation.dart';
import 'package:restaurant_api/common/style.dart';
import 'package:restaurant_api/data/api/api_service.dart';
import 'package:restaurant_api/data/db/database_helper.dart';
import 'package:restaurant_api/data/model/restaurant.dart';
import 'package:restaurant_api/data/preferences/preferences_helper.dart';
import 'package:restaurant_api/provider/database_provider.dart';
import 'package:restaurant_api/provider/preferences_provider.dart';
import 'package:restaurant_api/provider/restaurant_provider.dart';
import 'package:restaurant_api/provider/scheduling_provider.dart';
import 'package:restaurant_api/ui/detail_page.dart';
import 'package:restaurant_api/ui/favorite_page.dart';
import 'package:restaurant_api/ui/home_page.dart';
import 'package:restaurant_api/ui/settings_page.dart';
import 'package:restaurant_api/utils/background_service.dart';
import 'package:restaurant_api/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  await AndroidAlarmManager.initialize();
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

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
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
                sharedPreferences: SharedPreferences.getInstance()),
          ),
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
      navigatorKey: navigatorKey,
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        DetailPage.routeName: (context) => DetailPage(
            restaurant:
                ModalRoute.of(context)?.settings.arguments as Restaurant),
        FavoritePage.routeName: (context) => const FavoritePage(),
        SettingsPage.routeName: (context) => const SettingsPage(),
      },
    );
  }
}
