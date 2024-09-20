import 'package:get_it/get_it.dart' show GetIt;

import '../util/overlay/loading/loading_screen.dart';

void setupLocator() {
  GetIt.I.registerSingleton<LoadingScreen>(LoadingScreen());
}
