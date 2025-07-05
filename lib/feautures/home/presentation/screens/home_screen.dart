import 'package:deula/core/di/service_locator.dart';

import 'package:deula/feautures/home/presentation/screens/bloc/meal_bloc.dart';
import 'package:deula/feautures/home/presentation/widgets/daily_chart.dart';
import 'package:deula/feautures/home/presentation/widgets/meal_card.dart';
import 'package:deula/feautures/home/presentation/widgets/sumary_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenContentState createState() => HomeScreenContentState();
}

class HomeScreenContentState extends State<HomeScreen> {
  
   @override
  void initState() {
    super.initState();
    context.read<MealBloc>().add(MealInitialEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: BlocBuilder<MealBloc, MealState>(
            builder: (context, state) {
              if (state is MealLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is MealLoaded) {
                final meals = state.meals;
                final totalCalories = meals.fold(
                  0.0,
                  (sum, m) => sum + m.calories,
                );
                final totalProtein = meals.fold(
                  0.0,
                  (sum, m) => sum + (m.protein ?? 0),
                );
                final totalFat = meals.fold(
                  0.0,
                  (sum, m) => sum + (m.fat ?? 0),
                );
                final totalSugar = meals.fold(
                  0.0,
                  (sum, m) => sum + (m.sugar ?? 0),
                );

                return SingleChildScrollView(
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
                      DailyPieChart(meals: meals),
                      SizedBox(height: 24.h),
                      Text(
                        tr("meals_today"),
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      if (meals.isEmpty)
                        Center(child: Text(tr("no_meals_found")))
                      else
                        ...meals.map((m) => MealCard(meal: m)).toList(),
                      SizedBox(height: 100.h),
                    ],
                  ),
                );
              }

              if (state is MealError) {
                return Center(child: Text(state.message));
              }

              return const SizedBox.shrink(); // default fallback
            },
          ),
        ),
      ),
    );
  }
}
