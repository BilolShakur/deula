import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:deula/feautures/home/domain/models/meal_model.dart';
import 'package:easy_localization/easy_localization.dart';

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
    final double knownTotal = proteinCals + fatCals + sugarCals;
    final double otherCals = totalCalories - knownTotal;

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
                  centerSpaceRadius: 50,
                  startDegreeOffset: -90,
                  sections: data.map((entry) {
                    final percent =
                        ((entry['value'] as double) / totalCalories) * 100;
                    return PieChartSectionData(
                      color: entry['color'] as Color,
                      value: entry['value'] as double,
                      title: '${percent.toStringAsFixed(1)}%',
                      radius: 60,
                      titleStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
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
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    "${totalCalories.toInt()} kcal",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          children: data.map((entry) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: entry['color'] as Color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Text(entry['title'] as String),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
