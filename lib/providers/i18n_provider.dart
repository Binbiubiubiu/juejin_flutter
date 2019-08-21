import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class I18nProvider with ChangeNotifier {
  Locale _locale = Locale('zh', 'CN');
  bool _isNight = false;

  get locale => _locale;

  get isNight => _isNight;

  I18nProvider() : super();

  init(){
    timeago.setLocaleMessages(_locale.countryCode, timeago.ZhCnMessages());
  }

  setIsNight(){
    _isNight=!_isNight;
    timeago.setLocaleMessages(_isNight?'zh':'en', timeago.ZhCnMessages());
    notifyListeners();
  }


}
