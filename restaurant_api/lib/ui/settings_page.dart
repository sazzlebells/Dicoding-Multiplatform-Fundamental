import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/provider/preferences_provider.dart';
import 'package:restaurant_api/provider/scheduling_provider.dart';
import 'package:restaurant_api/utils/enums.dart';
import 'package:restaurant_api/widgets/bottom_nav_bar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);
  static const routeName = "/settings";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return ListView(
            children: [
              ListTile(
                title: const Text("Daily Recommendation"),
                subtitle: const Text("Enable restaurant recommendation"),
                trailing: Consumer<SchedulingProvider>(
                    builder: (context, schedule, _) {
                  return Switch.adaptive(
                      value: provider.isDailyRestoActive,
                      onChanged: (value) async {
                        schedule.scheduledRestaurants(value);
                        provider.enableDailyResto(value);
                      });
                }),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: const BottomNavBar(selectedMenu: MenuState.setting),
    );
  }
}
