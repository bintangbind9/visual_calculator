import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../common/constant/app_color.dart';

part 'main_color_index_event.dart';

class MainColorIndexBloc extends Bloc<MainColorIndexEvent, int> {
  MainColorIndexBloc() : super(0) {
    on<UpdateMainColorIndex>((event, emit) {
      int result = state + 1;
      if (result < 0 || result > AppColor.mainColors.length - 1) result = 0;
      emit(result);
    });

    on<SetMainColorIndex>((event, emit) {
      emit(event.index);
    });
  }
}
