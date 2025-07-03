import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TipCard extends StatelessWidget {
  final String tip;

  const TipCard({super.key, required this.tip});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          const Icon(Icons.lightbulb_outline, color: Colors.orange),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(tip, style: TextStyle(fontSize: 14.sp)),
          ),
        ],
      ),
    );
  }
}
