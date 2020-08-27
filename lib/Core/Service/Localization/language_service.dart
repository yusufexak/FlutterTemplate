import 'package:flutter/cupertino.dart';

class LanguageService {
  static LanguageService _instance;
  static LanguageService get instance {
    if (_instance == null) _instance = LanguageService._init();
    return _instance;
  }

  LanguageService._init();

  final String path = "assets/lang";

  final enLocale = Locale("en", "US");
  final trLocale = Locale("tr", "TR");
  final deLocale = Locale('de', 'DE');

  List<Locale> get locales => [
        enLocale,
        trLocale,
        deLocale,
      ];
}
