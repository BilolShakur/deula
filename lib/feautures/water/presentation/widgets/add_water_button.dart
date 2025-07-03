// lib/features/drink_water/widgets/add_water_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddWaterButton extends StatelessWidget {
  final void Function(double amount) onAdd;

  const AddWaterButton({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onAdd(250),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Text(
        "+250ml",
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
      ),
    );
  }
}
