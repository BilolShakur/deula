// lib/features/drink_water/model/water_data.dart
class WaterData {
  final double currentMl;
  final double goalMl;

  WaterData({required this.currentMl, required this.goalMl});

  WaterData copyWith({double? currentMl, double? goalMl}) {
    return WaterData(
      currentMl: currentMl ?? this.currentMl,
      goalMl: goalMl ?? this.goalMl,
    );
  }
}
