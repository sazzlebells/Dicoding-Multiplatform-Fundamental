import 'dart:convert';
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_api/common/navigation.dart';
import 'package:restaurant_api/data/model/restaurant.dart';
import 'package:restaurant_api/ui/detail_page.dart';
import 'package:rxdart/subjects.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid = AndroidInitializationSettings('icon');
    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        print('notification payload: ' + payload);
        configureSelectNotificationSubject(DetailPage.routeName);
      }
      selectNotificationSubject.add(payload!);
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestaurantResult restaurants) async {
    var _channelId = "1";
    var _channelName = "channel_01";
    var _channelDescription = "restaurant app channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName, _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: DefaultStyleInformation(true, true));
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    Random random = new Random();
    int randomNumber = random.nextInt(restaurants.restaurants!.length - 1);
    var restaurant = restaurants.restaurants![randomNumber];

    var titleNotification = "<b>${restaurant.name}</b>";
    var subTitleNotification = 'Recommendation restaurant for you';

    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, subTitleNotification, platformChannelSpecifics,
        payload: json.encode(restaurant.toJson()));
  }

  Future configureSelectNotificationSubject(String route) async {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        print('open restaurant here from notif');
        var restaurant = Restaurant.fromJson(json.decode(payload));
        Navigation.intentWithData(route, restaurant);
      },
    );
  }
}
