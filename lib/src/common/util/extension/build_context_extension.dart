import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    show AppLocalizations;

extension BuildContextExtension on BuildContext {
  AppLocalizations get local => AppLocalizations.of(this)!;
}
