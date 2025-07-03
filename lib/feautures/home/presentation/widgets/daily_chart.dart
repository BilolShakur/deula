import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:deula/feautures/home/domain/models/meal_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DailyPieChart extends StatelessWidget {
  final List<MealData> meals;

  const DailyPieChart({Key? key, required this.meals}) : super(key: key);

  double get totalCalories => meals.fold(0, (sum, item) => sum + item.calories);
  double get totalProtein =>
      meals.fold(0, (sum, item) => sum + (item.protein ?? 0));
  double get totalFat => meals.fold(0, (sum, item) => sum + (item.fat ?? 0));
  double get totalSugar =>
      meals.fold(0, (sum, item) => sum + (item.sugar ?? 0));

  @override
  Widget build(BuildContext context) {
    final double proteinCals = totalProtein * 4;
    final double fatCals = totalFat * 9;
    final double sugarCals = totalSugar * 4;
    final double knownCals = proteinCals + fatCals + sugarCals;
    final double otherCals = (totalCalories - knownCals).clamp(
      0,
      double.infinity,
    );

    final data = [
      {
        'title': 'label_protein'.tr(),
        'value': proteinCals,
        'color': Colors.blue,
      },
      {'title': 'label_fat'.tr(), 'value': fatCals, 'color': Colors.red},
      {'title': 'label_sugar'.tr(), 'value': sugarCals, 'color': Colors.orange},
      if (otherCals > 0)
        {'title': 'other'.tr(), 'value': otherCals, 'color': Colors.grey},
    ];

    final double total = data.fold(
      0.0,
      (sum, e) => sum + (e['value'] as double),
    );

    if (total == 0) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            tr("no_nutrition_info"),
            style: TextStyle(fontSize: 16.sp, color: Colors.grey),
          ),
        ),
      );
    }

    return Column(
      children: [
        SizedBox(
          height: 260,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PieChart(
                PieChartData(
                  sectionsSpace: 4,
                  centerSpaceRadius: 52,
                  startDegreeOffset: -90,
                  sections: data.map((entry) {
                    final percent = ((entry['value'] as double) / total * 100)
                        .clamp(0, 100);
                    return PieChartSectionData(
                      color: entry['color'] as Color,
                      value: entry['value'] as double,
                      title: '${percent.toStringAsFixed(1)}%',
                      radius: 60,
                      titleStyle: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    );
                  }).toList(),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "total".tr(),
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  ),
                  Text(
                    "${totalCalories.toInt()} kcal",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Wrap(
          spacing: 16.w,
          runSpacing: 10.h,
          children: data.map((entry) {
            final value = entry['value'] as double;
            final color = entry['color'] as Color;
            final title = entry['title'] as String;
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 12.w,
                  height: 12.w,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 6.w),
                Text(
                  "$title (${value.toInt()} kcal)",
                  style: TextStyle(fontSize: 13.sp),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
