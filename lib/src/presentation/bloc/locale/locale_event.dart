part of 'locale_bloc.dart';

@immutable
sealed class LocaleEvent {}

class UpdateLocale extends LocaleEvent {
  final Locale locale;
  UpdateLocale({required this.locale});
}
