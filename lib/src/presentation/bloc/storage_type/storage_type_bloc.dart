import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../common/enum/storage_type.dart';

part 'storage_type_event.dart';

class StorageTypeBloc extends Bloc<StorageTypeEvent, StorageType> {
  StorageTypeBloc() : super(StorageType.database) {
    on<UpdateStorageType>((event, emit) {
      emit(event.storageType);
    });
  }
}
