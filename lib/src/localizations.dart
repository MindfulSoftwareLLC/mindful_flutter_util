import 'package:intl/intl.dart';

class LibLocalizations {
  static LibLocalizations? _instance;

  static LibLocalizations get instance {
    if (_instance == null) {
      _instance = LibLocalizations();
    }
    return _instance!;
  }

  String get hello =>
      Intl.message('Hello', name: 'hello', desc: 'Greeting message');

// Add more localized strings here
}
