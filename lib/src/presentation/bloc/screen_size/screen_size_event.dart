part of 'screen_size_bloc.dart';

@immutable
sealed class ScreenSizeEvent {}

class UpdateScreenSize extends ScreenSizeEvent {
  final ScreenSize screenSize;
  UpdateScreenSize({required this.screenSize});
}
