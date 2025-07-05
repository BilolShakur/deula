class WaterState {
  final int currentAmount;
  final int goalAmount;
  WaterState({
    required this.currentAmount,
     this.goalAmount =2000,
  });
  double get progress => (currentAmount / goalAmount).clamp(0.0, 1.0);

  WaterState copyWith({
    int? currentAmount,
    int? goalAmount,
  }) {
    return WaterState(
      currentAmount: currentAmount ?? this.currentAmount,
      goalAmount: goalAmount ?? this.goalAmount,
    );
  }
}
