import 'package:flutter/widgets.dart';
import 'package:mindful_flutter_util/mindful_flutter_util.dart';

/// This is app logic that's actually reusable.
/// TODO - show how FlutterBus decouples the logics
class SettingsLogic with ThrottledSaveLoadMixin {
  @override
  String get fileName => 'settings.dat';

  late final hasCompletedOnboarding = ValueNotifier<bool>(false)
    ..addListener(scheduleSave);
  late final lastOnboardingIntroIndex = ValueNotifier<int?>(null)
    ..addListener(scheduleSave);
  late final currentLocale = ValueNotifier<String?>(null)
    ..addListener(scheduleSave);
  late final useBlurs = ValueNotifier<bool>(true)..addListener(scheduleSave);

  Future<void> changeLocale(Locale value) async {
    currentLocale.value = value.languageCode;
    //await localeLogic.loadIfChanged(value);
  }

  @override
  void copyFromJson(Map<String, dynamic> value) {
    currentLocale.value = value['currentLocale'];
    hasCompletedOnboarding.value = value['hasCompletedOnboarding'] ?? false;
    lastOnboardingIntroIndex.value = value['lastOnboardingIntroIndex'] ?? 0;
    useBlurs.value = value['useBlurs'] ?? true;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'currentLocale': currentLocale.value,
      'hasCompletedOnboarding': hasCompletedOnboarding.value,
      'lastOnboardingIntroIndex': lastOnboardingIntroIndex.value,
      'useBlurs': useBlurs.value,
    };
  }
}
