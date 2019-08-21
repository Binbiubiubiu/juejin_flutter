import 'package:flutter/material.dart';

class I18nProvider with ChangeNotifier {
  Locale _locale = Locale('zh','CN');

  get locale => _locale;

  setLocale(Locale locale) {
    _locale=locale;
    notifyListeners();
  }

}