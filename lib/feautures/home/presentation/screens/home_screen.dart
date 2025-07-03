import 'package:deula/core/di/service_locator.dart';
import 'package:deula/feautures/home/presentation/widgets/daily_chart.dart';
import 'package:deula/feautures/home/data/meal_reposotory.dart';
import 'package:deula/feautures/home/domain/models/meal_model.dart';
import 'package:deula/feautures/home/presentation/widgets/meal_card.dart';
import 'package:deula/feautures/home/presentation/widgets/sumary_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final _repo = sl<MealRepository>();
  List<MealData> _meals = [];

  @override
  void initState() {
    super.initState();
    reloadMeals();
  }

  Future<void> reloadMeals() async {
    final data = await _repo.fetchMeals();
    setState(() => _meals = data);
  }

  @override
  Widget build(BuildContext context) {
    final totalCalories = _meals.fold(0.0, (sum, m) => sum + m.calories);
    final totalProtein = _meals.fold(0.0, (sum, m) => sum + (m.protein ?? 0));
    final totalFat = _meals.fold(0.0, (sum, m) => sum + (m.fat ?? 0));
    final totalSugar = _meals.fold(0.0, (sum, m) => sum + (m.sugar ?? 0));

    return Scaffold(
      // Optional: floatingActionButton for testing delete
      floatingActionButton: _meals.isNotEmpty
          ? FloatingActionButton(
              onPressed: () async {
                // await _repo.deleteMeal(_meals.first.id!);
                // reloadMeals();

              },
              backgroundColor: Colors.red,
              child: const Icon(Icons.delete),
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr("greeting", namedArgs: {"name": "Bilol"}),
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  tr("quote_you_are_what_you_eat"),
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                ),
                SizedBox(height: 20.h),
                SummaryCard(
                  calories: "${totalCalories.toInt()} kcal",
                  water: '2L',
                  protein: "${totalProtein.toInt()} g",
                  fat: "${totalFat.toInt()} g",
                  sugar: "${totalSugar.toInt()} g",
                ),
                SizedBox(height: 24.h),
                DailyPieChart(meals: _meals),
                SizedBox(height: 24.h),
                Text(
                  tr("meals_today"),
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.h),
                if (_meals.isEmpty)
                  Center(child: Text(tr("no_meals_found")))
                else
                  ..._meals.map((m) => MealCard(meal: m)).toList(),
                SizedBox(height: 100.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
