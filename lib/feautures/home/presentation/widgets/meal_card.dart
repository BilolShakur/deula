import 'package:deula/core/constants/app_colors.dart';
import 'package:deula/core/constants/app_styles.dart';
import 'package:deula/feautures/home/domain/models/meal_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class MealCard extends StatelessWidget {
  final MealData meal;

  const MealCard({super.key, required this.meal});

  (Color bgColor, String? reason, Color textColor, IconData? icon)
  getHealthStatus() {
    final sugar = meal.sugar ?? 0;
    final fat = meal.fat ?? 0;
    final protein = meal.protein ?? 0;
    final calories = meal.calories;

    final hasOnlySugar = sugar > 0 && fat == 0 && protein == 0;
    final hasNoInfo = sugar == 0 && fat == 0 && protein == 0 && calories == 0;

    if (sugar > 35) {
      return (
        Colors.red.shade200,
        tr("very_high_sugar"),
        Colors.red.shade900,
        Icons.warning,
      );
    }
    if (fat > 35) {
      return (
        Colors.red.shade200,
        tr("high_fat"),
        Colors.red.shade900,
        Icons.warning,
      );
    }
    if (sugar > 25) {
      return (
        Colors.red.shade100,
        tr("high_sugar"),
        Colors.red.shade800,
        Icons.warning,
      );
    }
    if (fat > 25) {
      return (
        Colors.red.shade100,
        tr("high_fat"),
        Colors.red.shade800,
        Icons.warning,
      );
    }
    if (hasOnlySugar) {
      return (
        Colors.red.shade100,
        tr("only_sugar_no_nutrients"),
        Colors.red.shade800,
        Icons.warning,
      );
    }
    if (calories < 300 && protein < 5) {
      return (
        Colors.red.shade100,
        tr("low_cals_protein"),
        Colors.red.shade800,
        Icons.warning,
      );
    }
    if (sugar > 15) {
      return (
        Colors.orange.shade100,
        tr("high_sugar"),
        Colors.orange.shade800,
        Icons.info_outline,
      );
    }
    if (fat > 15) {
      return (
        Colors.orange.shade100,
        tr("high_fat"),
        Colors.orange.shade800,
        Icons.info_outline,
      );
    }
    if (protein < 10 && calories > 400) {
      return (
        Colors.orange.shade100,
        tr("low_protein"),
        Colors.orange.shade800,
        Icons.info_outline,
      );
    }
    if (protein > 40) {
      return (
        Colors.green.shade100,
        tr("label_protein"), // Optional override
        Colors.green.shade800,
        Icons.check_circle,
      );
    }
    if (protein > 25 && sugar < 5) {
      return (
        Colors.green.shade100,
        tr("great_protein_low_sugar"),
        Colors.green.shade800,
        Icons.check_circle,
      );
    }
    if (protein > 20 && fat < 15 && sugar < 10) {
      return (
        Colors.green.shade50,
        tr("nutritional_balance"),
        Colors.green.shade800,
        Icons.check_circle,
      );
    }
    if (hasNoInfo) {
      return (
        Colors.grey.shade200,
        tr("no_nutrition_info"),
        Colors.grey.shade700,
        Icons.info_outline,
      );
    }
    return (
      AppColors.primaryBg,
      tr("healthy"),
      Colors.green.shade700,
      Icons.check_circle,
    );
  }

  @override
  Widget build(BuildContext context) {
    final (bgColor, reason, textColor, icon) = getHealthStatus();

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        width: 380.w,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(meal.title, style: AppTextStyles.subheading),
              SizedBox(height: 8.h),

              _infoRow(tr("label_calories"), "${meal.calories.toInt()} kcal"),
              _infoRow(tr("label_protein"), "${meal.protein ?? 0} g"),
              _infoRow(tr("label_fat"), "${meal.fat ?? 0} g"),
              _infoRow(tr("label_sugar"), "${meal.sugar ?? 0} g"),

              if (reason != null && icon != null) ...[
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Icon(icon, color: textColor, size: 18.sp),
                    SizedBox(width: 6.w),
                    Text(
                      reason,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        children: [
          Text("$label:  ", style: AppTextStyles.cardTitle),
          Text(value, style: AppTextStyles.cardTitle),
        ],
      ),
    );
  }
}
