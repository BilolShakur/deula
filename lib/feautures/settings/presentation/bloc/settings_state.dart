part of 'settings_bloc.dart';

class SettingsState {
  final String  language;
  final bool isLight ;

  SettingsState({required this.language, required this.isLight});

  SettingsState copyWith({
    String? language,
    bool? isLight,
  }) {
    return SettingsState(
      language: language ?? this.language,
      isLight: isLight ?? this.isLight,
    );
  }
}