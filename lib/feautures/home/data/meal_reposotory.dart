
import 'package:deula/data/sql/dp_helper.dart';
import 'package:deula/feautures/home/domain/models/meal_model.dart';

class MealRepository {

  Future<List<MealData>> fetchMeals() async {
    final data = await DBHelper.getMeals();
    return data.map((e) => MealData.fromMap(e)).toList();
  }


  Future<void> addMeal(MealData meal) async {
    await DBHelper.insertMeal(meal.toMap());
  }


  Future<void> deleteMeal(int id) async {
    await DBHelper.deleteMeal(id);
  }


  Future<MealData?> getMeal(int id) async {
    final data = await DBHelper.getMeals();
    final mealMap = data.firstWhere((e) => e['id'] == id, orElse: () => {});
    if (mealMap.isEmpty) return null;
    return MealData.fromMap(mealMap);
  }
}
