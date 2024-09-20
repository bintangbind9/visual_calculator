part of 'theme_mode_bloc.dart';

@immutable
sealed class ThemeModeEvent {}

class UpdateThemeMode extends ThemeModeEvent {
  final ThemeMode themeMode;
  UpdateThemeMode({required this.themeMode});
}
