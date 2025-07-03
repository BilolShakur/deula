import 'package:deula/feautures/home/data/meal_reposotory.dart';
import 'package:get_it/get_it.dart';


final sl = GetIt.instance;

Future<void> setupLocator() async {
  // Register repositories
  sl.registerLazySingleton<MealRepository>(() => MealRepository());
}
