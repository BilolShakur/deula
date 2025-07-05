import 'dart:math';

import 'package:deula/feautures/water/presentation/bloc/water_bloc.dart';
import 'package:deula/feautures/water/presentation/bloc/water_event.dart';
import 'package:deula/feautures/water/presentation/bloc/water_state.dart';
import 'package:deula/feautures/water/presentation/widgets/water_amount_selector.dart';
import 'package:deula/feautures/water/presentation/widgets/water_tank.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class WaterScreen extends StatefulWidget {
  const WaterScreen({super.key});

  @override
  State<WaterScreen> createState() => _WaterScreenState();
}

class _WaterScreenState extends State<WaterScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _splashController;
  late Animation<double> _fadeSplash;

  final double dailyGoalMl = 2000.0;

  @override
  void initState() {
    super.initState();

    _splashController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    _fadeSplash = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_splashController);

    // This is the missing part
    context.read<WaterBloc>().add(InitWaterEvent());
  }

  void handleAddWater(double ml) {
    context.read<WaterBloc>().add(AddWater(amount: ml.toInt()));
    _splashController.forward(from: 0.0);
  }

  @override
  void dispose() {
    _splashController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              Text(
                'water_tracker'.tr(),
                style: TextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              SizedBox(height: 20.h),
              BlocBuilder<WaterBloc, WaterState>(
                builder: (context, state) {
                  final double percent = min(
                    state.currentAmount / dailyGoalMl,
                    1.0,
                  );

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      WaterTank(level: percent),
                      FadeTransition(
                        opacity: _fadeSplash,
                        child: Icon(
                          Icons.water_drop,
                          color: Colors.white.withOpacity(0.6),
                          size: 80.sp,
                        ),
                      ),
                      Positioned(
                        top: 40.h,
                        child: Column(
                          children: [
                            Text(
                              '${(percent * 100).toStringAsFixed(0)}%',
                              style: TextStyle(
                                fontSize: 48.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              '${state.currentAmount.toStringAsFixed(0)} / ${dailyGoalMl.toStringAsFixed(0)} ml',
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 40.h),
              WaterAmountSelector(onSelectAmount: handleAddWater),
            ],
          ),
        ),
      ),
    );
  }
}
