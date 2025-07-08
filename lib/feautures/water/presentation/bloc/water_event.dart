abstract class WaterEvent {}

class LoadWaterEvent extends WaterEvent {}

class AddWater extends WaterEvent {
  final int amount;
  AddWater({required this.amount});
}

class ResetWaterEvent extends WaterEvent {}

class InitWaterEvent extends WaterEvent {}

class getWatersByDate extends WaterEvent {
  final DateTime start;
  final DateTime end;
  getWatersByDate({required this.start, required this.end});
}

class GetWaterToday extends WaterEvent {}
