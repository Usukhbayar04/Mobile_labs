import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/global_keys.dart';
import 'package:shop_app/provider/globalProvider.dart';
import 'package:shop_app/login_page.dart';
import 'package:shop_app/repository/repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Global_provider()),
        Provider(create: (_) => MyRepository()),
      ],
      child: EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('mn', 'MN'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: GlobalKeys.navigatorKey,
      theme: ThemeData(
        useMaterial3: false,
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: const Locale('mn', 'MN'),
      home: const SafeArea(
        child: LoginPage(),
      ),
    );
  }
}
