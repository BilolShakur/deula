import 'package:deula/data/sql/dp_helper.dart';
import 'package:deula/feautures/home/domain/models/meal_model.dart';

class MealRepository {
  // All meals
  Future<List<MealData>> fetchMeals() async {
    final data = await DBHelper.getMeals();
    return data.map((e) => MealData.fromMap(e)).toList();
  }

  Future<List<Map<String, dynamic>>> fetchMealsBetween(DateTime start, DateTime end) {
    return DBHelper.getMealsBetween(start, end);
  }

  // Today's meals
  Future<List<MealData>> fetchTodayMeals() async {
    final data = await DBHelper.getTodayMeals();
    return data.map((e) => MealData.fromMap(e)).toList();
  }

  // This week's meals
  Future<List<MealData>> fetchWeekMeals() async {
    final data = await DBHelper.getWeekMeals();
    return data.map((e) => MealData.fromMap(e)).toList();
  }

  // This month's meals
  Future<List<MealData>> fetchMonthMeals() async {
    final data = await DBHelper.getMonthMeals();
    return data.map((e) => MealData.fromMap(e)).toList();
  }

  // Add new meal
  Future<void> addMeal(MealData meal) async {
    await DBHelper.insertMeal(meal.toMap());
  }

  // Delete by ID
  Future<void> deleteMeal(int id) async {
    await DBHelper.deleteMeal(id);
  }

  // Get one meal by ID
  Future<MealData?> getMeal(int id) async {
    final data = await DBHelper.getMeals();
    final mealMap = data.firstWhere((e) => e['id'] == id, orElse: () => {});
    if (mealMap.isEmpty) return null;
    return MealData.fromMap(mealMap);
  }
}
