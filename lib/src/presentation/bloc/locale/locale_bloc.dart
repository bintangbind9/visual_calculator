import 'dart:ui' show Locale;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'locale_event.dart';

class LocaleBloc extends Bloc<LocaleEvent, Locale> {
  LocaleBloc() : super(const Locale('en')) {
    on<UpdateLocale>((event, emit) {
      emit(event.locale);
    });
  }
}
