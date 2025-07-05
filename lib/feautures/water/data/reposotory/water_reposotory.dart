import 'package:deula/data/sql/dp_helper_water.dart';

class WaterRepository {
  Future<void> addWater(double amount) async {
    await WaterDBHelper.insertWater(amount);
  }

  Future<double> getTotalConsumedWater() async {
    return await WaterDBHelper.getTotalWater();
  }

  Future<void> clearWaterHistory() async {
    await WaterDBHelper.clearAll();
  }

  // ✅ Get water consumed today
  Future<double> getTodayWater() async {
    return await WaterDBHelper.getWaterBetween(
      DateTime.now(),
      DateTime.now().add(const Duration(days: 1)),
    );
  }

  // ✅ Get water consumed this week
  Future<double> getWeekWater() async {
    final now = DateTime.now();
    final startOfWeek = DateTime(
      now.year,
      now.month,
      now.day - (now.weekday - 1),
    );
    final endOfWeek = startOfWeek.add(const Duration(days: 7));
    return await WaterDBHelper.getWaterBetween(startOfWeek, endOfWeek);
  }

  // ✅ Get water consumed this month
  Future<double> getMonthWater() async {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final startOfNextMonth = now.month < 12
        ? DateTime(now.year, now.month + 1, 1)
        : DateTime(now.year + 1, 1, 1);
    return await WaterDBHelper.getWaterBetween(startOfMonth, startOfNextMonth);
  }
}
