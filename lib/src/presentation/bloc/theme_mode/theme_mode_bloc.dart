import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_mode_event.dart';

class ThemeModeBloc extends Bloc<ThemeModeEvent, ThemeMode> {
  ThemeModeBloc() : super(ThemeMode.system) {
    on<UpdateThemeMode>((event, emit) {
      emit(event.themeMode);
    });
  }
}
