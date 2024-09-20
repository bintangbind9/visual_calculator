import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/app.dart';
import 'src/presentation/bloc/locale/locale_bloc.dart';
import 'src/presentation/bloc/main_color_index/main_color_index_bloc.dart';
import 'src/presentation/bloc/theme_mode/theme_mode_bloc.dart';

void main() async {
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
      ],
      child: const App(),
    ),
  );
}
