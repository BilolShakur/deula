import 'package:deula/feautures/water/data/reposotory/water_reposotory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'water_event.dart';
import 'water_state.dart';

class WaterBloc extends Bloc<WaterEvent, WaterState> {
  final WaterRepository repository;

  WaterBloc({required this.repository}) : super(WaterState(currentAmount: 0)) {
    on<AddWater>(_onAddWater);
    on<ResetWaterEvent>(_onResetWater);
    on<InitWaterEvent>(_onInitWater);
    on<GetWaterToday>(_onfetchWaterToday);
    on<getWatersByDate>(_onfetchWaterByData);
  }

  Future<void> _onAddWater(AddWater event, Emitter<WaterState> emit) async {
    final newAmount = state.currentAmount + event.amount;
    await repository.addWater(event.amount.toDouble()); // Save to DB
    emit(state.copyWith(currentAmount: newAmount));
  }

  Future<void> _onResetWater(
    ResetWaterEvent event,
    Emitter<WaterState> emit,
  ) async {
    await repository.clearWaterHistory();
    emit(state.copyWith(currentAmount: 0));
  }

  Future<void> _onInitWater(
    InitWaterEvent event,
    Emitter<WaterState> emit,
  ) async {
    final total = await repository.getTotalConsumedWater();
    emit(state.copyWith(currentAmount: total.toInt()));
  }

  Future<void> _onfetchWaterByData(
    getWatersByDate event,
    Emitter<WaterState> emit,
  ) async {
    final totalFor = await repository.getDataByDate(event.start , event.end);
    emit(state.copyWith(currentAmount: totalFor.toInt()));
  }

  Future<void> _onfetchWaterToday(
    GetWaterToday event,
    Emitter<WaterState> emit,
  ) async {
    final totalForToday = await repository.getTodayWater();
    emit(state.copyWith(currentAmount: totalForToday.toInt()));
  }
}
