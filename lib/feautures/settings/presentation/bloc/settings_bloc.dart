import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsState(language: 'en', isLight: true)) {
    on<changeLAnguage>((event, emit) {
      emit(state.copyWith(language: event.language));
    });

    on<toglleThemeEvent>((event, emit) {
      emit(state.copyWith(isLight:  event.light));
    });
  }
}
