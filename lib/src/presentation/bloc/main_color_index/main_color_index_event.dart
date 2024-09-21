part of 'main_color_index_bloc.dart';

@immutable
sealed class MainColorIndexEvent {}

class UpdateMainColorIndex extends MainColorIndexEvent {}

class SetMainColorIndex extends MainColorIndexEvent {
  final int index;
  SetMainColorIndex({required this.index});
}
