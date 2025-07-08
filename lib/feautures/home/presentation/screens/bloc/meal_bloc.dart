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
    on<FilterMealsByDate>(_onFilterMeals);
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
    if (state is MealLoaded) {
      final currentMeals = List<MealData>.from((state as MealLoaded).meals);
      final updatedMeals = [...currentMeals, event.meal];
      emit(MealLoaded(updatedMeals)); // optimistic update
    }

    try {
      await repository.addMeal(event.meal);
      final meals = await repository.fetchMeals(); // refetch from DB
      emit(MealLoaded(meals));
    } catch (e) {
      emit(MealError('Failed to add meal'));
    }
  }

  Future<void> _onFilterMeals(
    FilterMealsByDate event,
    Emitter<MealState> emit,
  ) async {
    emit(MealLoading());
    try {
      final rawMeals = await repository.fetchMealsBetween(
        event.start,
        event.end,
      );
      final meals = rawMeals.map((m) => MealData.fromMap(m)).toList();
      emit(MealLoaded(meals));
    } catch (e) {
      emit(MealError('Failed to filter meals'));
    }
  }
}
