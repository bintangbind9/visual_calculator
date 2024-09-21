import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../common/enum/screen_size.dart';

part 'screen_size_event.dart';

class ScreenSizeBloc extends Bloc<ScreenSizeEvent, ScreenSize> {
  ScreenSizeBloc() : super(ScreenSize.medium) {
    on<UpdateScreenSize>((event, emit) {
      emit(event.screenSize);
    });
  }
}
