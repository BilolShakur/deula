import 'package:deula/core/di/service_locator.dart';
import 'package:deula/feautures/home/data/meal_reposotory.dart';
import 'package:deula/feautures/home/presentation/screens/bloc/meal_bloc.dart';
import 'package:deula/feautures/main/bottom_navi.dart';
import 'package:deula/feautures/water/data/reposotory/water_reposotory.dart';
import 'package:deula/feautures/water/presentation/bloc/water_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await setupLocator();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              WaterBloc(repository: GetIt.instance<WaterRepository>()),
        ),
        BlocProvider(
          create: (context) => MealBloc(GetIt.instance<MealRepository>()),
        ),
      ],
      child: EasyLocalization(
        supportedLocales: const [
          Locale('en'), // English
          Locale('uz'), // Uzbek
          Locale('ru'), // Russian
        ],
        path: 'assets/translations',
        startLocale: const Locale("en"),
        fallbackLocale: const Locale('en'),
        child: const DeulaApp(),
      ),
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
