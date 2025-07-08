import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SummaryCard extends StatelessWidget {
  final String when; // "Today", "This Week", "Custom Date", etc.
  final String calories;
  final String water;
  final String protein;
  final String? fat;
  final String? sugar;

  const SummaryCard({
    Key? key,
    required this.when,
    required this.calories,
    required this.water,
    required this.protein,
    this.fat,
    this.sugar,
  }) : super(key: key);

  int getMultiplier() {
    if (when.contains("Week")) return 7;
    if (when.contains("Month")) return 30;
    return 1; // Today, Yesterday, Custom Date
  }

  (Color bg, Color textColor, IconData icon, String message) getStatus() {
    final multiplier = getMultiplier();

    final cal = int.tryParse(calories.replaceAll(RegExp(r'\D'), '')) ?? 0;
    final wat = double.tryParse(water.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
    final prot = int.tryParse(protein.replaceAll(RegExp(r'\D'), '')) ?? 0;
    final fatVal = int.tryParse(fat?.replaceAll(RegExp(r'\D'), '') ?? '0') ?? 0;
    final sugarVal =
        int.tryParse(sugar?.replaceAll(RegExp(r'\D'), '') ?? '0') ?? 0;

    int score = 0;
    bool waterDanger = false;

    // Calories
    if (cal < 700 * multiplier || cal > 3500 * multiplier) {
      score += 5;
    } else if (cal >= 1200 * multiplier && cal <= 2800 * multiplier) {
      score += 2;
    } else if (cal >= 1500 * multiplier && cal <= 2500 * multiplier) {
      score -= 4;
    }

    // Water
    if (wat < 1.5 * multiplier) {
      score += 2;
    } else if (wat >= 1.5 * multiplier && wat <= 3.5 * multiplier) {
      score -= 1;
    } else if (wat > 4 * multiplier && wat < 6 * multiplier) {
      score += 1;
    } else if (wat >= 6 * multiplier && wat < 8 * multiplier) {
      score += 2;
    } else if (wat >= 8 * multiplier) {
      waterDanger = true;
    }

    // Protein
    if (prot < 35 * multiplier) {
      score += 1;
    } else if (prot >= 100 * multiplier) {
      score -= 3;
    } else if (prot >= 700 * multiplier) {
      score -= 2;
    } else if (prot >= 50 * multiplier) {
      score -= 1;
    }

    // Fat
    if (fatVal > 60 * multiplier) {
      score += 3;
    } else if (fatVal > 50 * multiplier) {
      score += 2;
    } else if (fatVal > 40 * multiplier) {
      score += 1;
    } else if (fatVal < 15 * multiplier) {
      score -= 2;
    } else if (fatVal < 25 * multiplier) {
      score -= 1;
    }

    // Sugar
    if (sugarVal > 60 * multiplier) {
      score += 4;
    } else if (sugarVal > 50 * multiplier) {
      score += 3;
    } else if (sugarVal > 30 * multiplier) {
      score += 2;
    } else if (sugarVal > 20 * multiplier) {
      score += 1;
    } else if (sugarVal < 10 * multiplier) {
      score -= 1;
    } else if (sugarVal > 5 * multiplier) {
      score -= 2;
    }

    if (waterDanger) {
      return (
        Colors.red.shade100,
        Colors.red.shade900,
        Icons.warning_amber_rounded,
        tr("alert_danger_water_intake"),
      );
    }

    if (score >= 5) {
      return (
        Colors.red.shade100,
        Colors.red.shade900,
        Icons.warning,
        tr("alert_unbalanced_calories"),
      );
    } else if (score >= 3) {
      return (
        Colors.orange.shade100,
        Colors.orange.shade800,
        Icons.info_outline,
        tr("alert_decent_keep_up"),
      );
    } else if (score >= 1) {
      return (
        Colors.yellow.shade100,
        Colors.yellow.shade800,
        Icons.info_outline,
        tr("alert_decent_keep_up"),
      );
    } else {
      return (
        const Color.fromARGB(255, 177, 242, 179),
        Colors.green.shade800,
        Icons.check_circle,
        tr("alert_great_job"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final (bg, textColor, icon, message) = getStatus();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "summary_title".tr(namedArgs: {"period": "${when}'s"}),
            style: TextStyle(fontSize: 18.sp, color: textColor),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _summaryItem("label_calories".tr(), calories, textColor),
              _summaryItem("label_water".tr(), water, textColor),
              _summaryItem("label_protein".tr(), protein, textColor),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _summaryItem("label_fat".tr(), fat ?? "-", textColor),
              _summaryItem("label_sugar".tr(), sugar ?? "-", textColor),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Icon(icon, color: textColor, size: 18.sp),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(fontSize: 12.sp, color: color.withOpacity(0.7)),
        ),
      ],
    );
  }

  // Translation key mapping for summary title
}
