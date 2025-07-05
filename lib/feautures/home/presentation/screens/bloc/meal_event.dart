part of 'meal_bloc.dart';

@immutable
sealed class MealEvent {}

class MealInitialEvent extends MealEvent {}

class AddMeal extends MealEvent {
  final MealData meal;

  AddMeal(this.meal);
}
