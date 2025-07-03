import 'package:deula/core/di/service_locator.dart';

import 'package:deula/feautures/main/bottom_navi.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await setupLocator();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'), // English
        Locale('uz'), // Uzbek 
        Locale('ru'), // Russian
      ],
      path: 'assets/translations',
      startLocale: Locale("ru"),
      fallbackLocale: const Locale('ru'),
      child: const DeulaApp(),
    ),
  );
}

class DeulaApp extends StatelessWidget {
  const DeulaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 915),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Deula',
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: const MainScreen(),
        );
      },
    );
  }
}
