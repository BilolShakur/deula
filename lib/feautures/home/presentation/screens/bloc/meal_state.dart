part of 'meal_bloc.dart';

@immutable
sealed class MealState {
  const MealState();
}

class MealInitial extends MealState {}

class MealLoading extends MealState {}

class MealLoaded extends MealState {
  final List<MealData> meals;

  const MealLoaded(this.meals);
}

class MealError extends MealState {
  final String message;

  const MealError(this.message);
}
