import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shop_app/global_keys.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void changeLanguage() {
    final context = GlobalKeys.navigatorKey.currentContext;
    if (context!.locale.languageCode == const Locale('mn', 'MN').languageCode) {
      context.setLocale(const Locale('en', 'US'));
    } else {
      context.setLocale(const Locale('mn', 'MN'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              changeLanguage();
            },
            child: Text('Change language'.tr()),
          ),
        ],
      ),
    );
  }
}
