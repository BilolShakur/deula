import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class WaterAmountSelector extends StatelessWidget {
  final Function(double ml) onSelectAmount;

  const WaterAmountSelector({required this.onSelectAmount, super.key});

  @override
  Widget build(BuildContext context) {
    final List<double> options = [100, 250, 500];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: options.map((ml) {
        return GestureDetector(
          onTap: () => onSelectAmount(ml),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.blue[600],
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
            ),
            child: Text(
              'drink_amounts.${ml.toInt()}'.tr(),
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
