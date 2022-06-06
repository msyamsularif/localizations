import 'dart:ui';

class LanguageManager {
  static LanguageManager? _instace;
  static LanguageManager? get instance {
    _instace ??= LanguageManager._init();
    return _instace;
  }

  LanguageManager._init();

  final enLocale = const Locale('en', 'US');
  final idLocale = const Locale('id', 'ID');

  List<Locale> get supportedLocales => [idLocale, enLocale];
}
