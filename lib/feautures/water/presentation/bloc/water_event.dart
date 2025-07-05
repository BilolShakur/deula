abstract class WaterEvent {}

class LoadWaterEvent extends WaterEvent {}

class AddWater extends WaterEvent {
  final int amount;
  AddWater({required this.amount});
}

class ResetWaterEvent extends WaterEvent {}

class InitWaterEvent extends WaterEvent {}
