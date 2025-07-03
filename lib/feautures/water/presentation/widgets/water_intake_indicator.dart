// lib/features/drink_water/widgets/water_intake_indicator.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


class WaterIntakeIndicator extends StatelessWidget {
  final double progress;

  const WaterIntakeIndicator({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 100.r,
      lineWidth: 12.w,
      percent: progress.clamp(0.0, 1.0),
      backgroundColor: Colors.blue[100]!,
      progressColor: Colors.blueAccent,
      animation: true,
      circularStrokeCap: CircularStrokeCap.round,
      center: Text(
        '${(progress * 100).toStringAsFixed(0)}%',
        style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
      ),
    );
  }
}

