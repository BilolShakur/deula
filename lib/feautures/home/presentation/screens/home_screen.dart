import 'package:deula/core/di/service_locator.dart';
import 'package:deula/feautures/home/presentation/screens/bloc/meal_bloc.dart';

import 'package:deula/feautures/home/presentation/widgets/daily_chart.dart';
import 'package:deula/feautures/home/presentation/widgets/meal_card.dart';
import 'package:deula/feautures/home/presentation/widgets/sumary_container.dart';
import 'package:deula/feautures/water/presentation/bloc/water_bloc.dart';
import 'package:deula/feautures/water/presentation/bloc/water_event.dart';
import 'package:deula/feautures/water/presentation/bloc/water_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenContentState createState() => HomeScreenContentState();
}

class HomeScreenContentState extends State<HomeScreen> {
  String selectedFilter = 'Today';
  final List<String> filters = [
    'Today',
    'Yesterday',
    'This Week',
    'This Month',
    'Custom Date',
  ];

  @override
  void initState() {
    super.initState();
    context.read<MealBloc>().add(MealInitialEvent());
    context.read<WaterBloc>().add(InitWaterEvent());
    _applyFilter(selectedFilter);
  }

  void _applyFilter(String value) async {
    final now = DateTime.now();
    DateTime start;
    DateTime end;

    switch (value) {
      case 'Today':
        start = DateTime(now.year, now.month, now.day);
        end = now;
        break;
      case 'Yesterday':
        final yesterday = now.subtract(const Duration(days: 1));
        start = DateTime(yesterday.year, yesterday.month, yesterday.day);
        end = DateTime(
          yesterday.year,
          yesterday.month,
          yesterday.day,
          23,
          59,
          59,
        );
        break;
      case 'This Week':
        start = now.subtract(Duration(days: now.weekday - 1));
        end = now;
        break;
      case 'This Month':
        start = DateTime(now.year, now.month, 1);
        end = now;
        break;
      case 'Custom Date':
        final picked = await showDatePicker(
          context: context,
          initialDate: now,
          firstDate: DateTime(2023),
          lastDate: now,
        );
        if (picked == null) return;
        selectedFilter = DateFormat('yyyy-MM-dd').format(picked);
        start = DateTime(picked.year, picked.month, picked.day);
        end = DateTime(picked.year, picked.month, picked.day, 23, 59, 59);
        break;
      default:
        return;
    }

    setState(() {
      selectedFilter = value;
    });
    context.read<MealBloc>().add(FilterMealsByDate(start, end));
    context.read<WaterBloc>().add(getWatersByDate(start: start, end: end));
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
                      Row(
                        children: [
                          Text(
                            tr("greeting", namedArgs: {"name": "Bilol"}),
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          DropdownButtonHideUnderline(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1C1F2A),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: DropdownButton<String>(
                                value: filters.contains(selectedFilter)
                                    ? selectedFilter
                                    : 'Custom Date',
                                dropdownColor: const Color(0xFF1C1F2A),
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white70,
                                ),
                                style: const TextStyle(color: Colors.white),
                                onChanged: (value) {
                                  if (value != null) {
                                    _applyFilter(value);
                                  }
                                },
                                items: filters
                                    .map(
                                      (label) => DropdownMenuItem<String>(
                                        value: label,
                                        child: Text(
                                          label,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        tr("quote_you_are_what_you_eat"),
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                      ),
                      SizedBox(height: 20.h),
                      BlocBuilder<WaterBloc, WaterState>(
                        builder: (context, state) {
                          return SummaryCard(
                            calories: "${totalCalories.toInt()} kcal",
                            water:
                                '${(state.currentAmount / 1000).toStringAsFixed(1)} L',
                            protein: "${totalProtein.toInt()} g",
                            fat: "${totalFat.toInt()} g",
                            sugar: "${totalSugar.toInt()} g",
                          );
                        },
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

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
