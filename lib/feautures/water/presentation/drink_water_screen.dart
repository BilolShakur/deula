// lib/features/drink_water/screens/drink_water_screen.dart
import 'package:deula/feautures/water/data/water_data.dart';
import 'package:deula/feautures/water/presentation/widgets/%20water_goal_progress.dart';
import 'package:deula/feautures/water/presentation/widgets/add_water_button.dart';
import 'package:deula/feautures/water/presentation/widgets/water_intake_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DrinkWaterScreen extends StatefulWidget {
  const DrinkWaterScreen({super.key});

  @override
  State<DrinkWaterScreen> createState() => _DrinkWaterScreenState();
}

class _DrinkWaterScreenState extends State<DrinkWaterScreen> {
  WaterData waterData = WaterData(currentMl: 0, goalMl: 2000);

  void _addWater(double ml) {
    setState(() {
      waterData = waterData.copyWith(
        currentMl: (waterData.currentMl + ml).clamp(0, waterData.goalMl),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final progress = waterData.currentMl / waterData.goalMl;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Drink Water"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            SizedBox(height: 40.h),
            WaterIntakeIndicator(progress: progress),
            SizedBox(height: 24.h),
            WaterGoalProgress(
              totalDrank: waterData.currentMl / 1000,
              goal: waterData.goalMl / 1000,
            ),
            const Spacer(),
            AddWaterButton(onAdd: _addWater),
          ],
        ),
      ),
    );
  }
}
