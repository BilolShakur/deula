part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {}



class toglleThemeEvent extends SettingsEvent{
  final bool light;

  toglleThemeEvent({required this.light});
}



class  changeLAnguage  extends SettingsEvent{

final String language;

  changeLAnguage({required this.language});  
}
