import 'package:deula/feautures/home/data/meal_reposotory.dart';
import 'package:deula/feautures/water/data/reposotory/water_reposotory.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {

  sl.registerLazySingleton<MealRepository>(() => MealRepository());

  sl.registerLazySingleton<WaterRepository>(() => WaterRepository());
}
