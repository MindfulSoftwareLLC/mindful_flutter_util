import 'package:catcher/catcher.dart';
import 'package:flutter/widgets.dart';

/// Debug config default uses SilentReportMode(), [ConsoleHandler()]
/// Release configuration default uses DialogReportMode and the once user
/// accepts dialog, the user will be prompted to send email with crash to support.
void runAppCatchErrors(
    {required String supportEmail,
    Widget? rootWidget, //or a runAppFunction
    final void Function()? runAppFunction, //or a rootWidget
    GlobalKey<NavigatorState>? navigatorKey,
    CatcherOptions? debugOptions,
    CatcherOptions? releaseOptions}) {
  assert(
    (rootWidget == null && runAppFunction != null) ||
        (rootWidget != null && runAppFunction == null),
    'Either rootWidget or runAppFunction must be supplied.',
  );

  var silentReportMode = SilentReportMode();
  silentReportMode.setReportModeAction(NoopReportModeAction());
  CatcherOptions optionsForDebug = debugOptions == null
      ? CatcherOptions(silentReportMode, [ConsoleHandler()])
      : debugOptions;
  CatcherOptions optionsForRelease = releaseOptions == null
      ? CatcherOptions(DialogReportMode(), [
          EmailManualHandler([supportEmail])
        ])
      : releaseOptions;
  Catcher(
      rootWidget: rootWidget,
      debugConfig: optionsForDebug,
      releaseConfig: optionsForRelease,
      navigatorKey: navigatorKey,
      runAppFunction: runAppFunction);
}

class NoopReportModeAction extends ReportModeAction {
  @override
  void onActionConfirmed(Report report) {}

  @override
  void onActionRejected(Report report) {}
}
