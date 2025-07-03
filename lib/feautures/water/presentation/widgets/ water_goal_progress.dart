// lib/features/drink_water/widgets/water_goal_progress.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WaterGoalProgress extends StatelessWidget {
  final double totalDrank;
  final double goal;

  const WaterGoalProgress({
    super.key,
    required this.totalDrank,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${totalDrank.toStringAsFixed(1)}L / ${goal.toStringAsFixed(1)}L',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8.h),
        LinearProgressIndicator(
          value: (totalDrank / goal).clamp(0.0, 1.0),
          color: Colors.blueAccent,
          backgroundColor: Colors.blue[100],
          minHeight: 8.h,
          borderRadius: BorderRadius.circular(8.r),
        ),
      ],
    );
  }
}
