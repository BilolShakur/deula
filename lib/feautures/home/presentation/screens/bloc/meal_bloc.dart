import 'package:bloc/bloc.dart';

import 'package:deula/feautures/home/data/meal_reposotory.dart';
import 'package:deula/feautures/home/domain/models/meal_model.dart';
import 'package:meta/meta.dart';

part 'meal_event.dart';
part 'meal_state.dart';

class MealBloc extends Bloc<MealEvent, MealState> {
  final MealRepository repository;

  MealBloc(this.repository) : super(MealInitial()) {
    on<MealInitialEvent>(_onInitMeals);
    on<AddMeal>(_onAddMeal);
  }

  Future<void> _onInitMeals(
    MealInitialEvent event,
    Emitter<MealState> emit,
  ) async {
    emit(MealLoading());
    try {
      final meals = await repository.fetchMeals();
      emit(MealLoaded(meals));
    } catch (e) {
      emit(MealError('Failed to load meals'));
    }
  }

  Future<void> _onAddMeal(AddMeal event, Emitter<MealState> emit) async {
    try {
      await repository.addMeal(event.meal);
      final meals = await repository.fetchMeals();
      emit(MealLoaded(meals));
    } catch (e) {
      emit(MealError('Failed to add meal'));
    }
  }
}
