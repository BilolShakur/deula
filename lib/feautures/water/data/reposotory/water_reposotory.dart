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
}
