import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/app.dart';
import 'src/common/service_locator/locator.dart';
import 'src/presentation/bloc/calculation_history/calculation_history_bloc.dart';
import 'src/presentation/bloc/locale/locale_bloc.dart';
import 'src/presentation/bloc/main_color_index/main_color_index_bloc.dart';
import 'src/presentation/bloc/screen_size/screen_size_bloc.dart';
import 'src/presentation/bloc/theme_mode/theme_mode_bloc.dart';

void main() async {
  setupLocator();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MainColorIndexBloc(),
        ),
        BlocProvider(
          create: (context) => LocaleBloc(),
        ),
        BlocProvider(
          create: (context) => ThemeModeBloc(),
        ),
        BlocProvider(
          create: (context) => ScreenSizeBloc(),
        ),
        BlocProvider(
          create: (context) => CalculationHistoryBloc(),
        ),
      ],
      child: const App(),
    ),
  );
}
