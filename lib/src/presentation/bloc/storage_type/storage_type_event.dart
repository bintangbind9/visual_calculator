part of 'storage_type_bloc.dart';

@immutable
sealed class StorageTypeEvent {}

class UpdateStorageType extends StorageTypeEvent {
  final StorageType storageType;
  UpdateStorageType({required this.storageType});
}
