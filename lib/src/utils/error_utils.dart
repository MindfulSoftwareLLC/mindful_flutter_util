import 'dart:async';
import 'dart:io';

import 'package:catcher/catcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stack_trace/stack_trace.dart';

/// Launch your app like this to maximize error catching safety,
/// report errors to logs and to a support email in production from user
/// email accounts.
/// The rootWidget or a runAppFunction must be supplied but not both.
/// You'll need your Navigator to have a key, of course.
/// Debug config default uses SilentReportMode(), [ConsoleHandler()]
/// Release configuration default uses DialogReportMode and the once user
/// accepts dialog, the user will be prompted to send email with crash to support.
void runAppCatchErrors(
    {required String supportEmail,
    Widget? rootWidget,
    GlobalKey<NavigatorState>? navigatorKey,
    final void Function()? runAppFunction, //or a rootWidget
    CatcherOptions? debugOptions,
    CatcherOptions? releaseOptions}) {
  assert(
    (rootWidget == null && runAppFunction != null) ||
        (rootWidget != null && runAppFunction == null),
    'Either rootWidget or runAppFunction must be supplied but not both.',
  );

  registerErrorHandlers();
  // CatcherOptions optionsForDebug = debugOptions ??
  //     CatcherOptions(DialogReportMode(), [ConsoleHandler()],
  //         handlerTimeout: 10000,
  //         customParameters: <String, dynamic>{},
  //         localizationOptions: [],
  //         explicitExceptionReportModesMap: {},
  //         explicitExceptionHandlersMap: {},
  //         handleSilentError: true,
  //         screenshotsPath: '',
  //         excludedParameters: const [],
  //         filterFunction: null,
  //         reportOccurrenceTimeout: 3000,
  //         logger: CatcherLogger());
  // CatcherOptions optionsForRelease =
  //     releaseOptions ?? CatcherOptions.getDefaultReleaseOptions()
  //       ..handlers.add(EmailManualHandler([supportEmail]));
  // Catcher(
  //   rootWidget: rootWidget,
  //   debugConfig: optionsForDebug,
  //   releaseConfig: optionsForRelease,
  //   navigatorKey: navigatorKey,
  //   runAppFunction: runAppFunction,
  //   ensureInitialized: true,
  //   profileConfig: CatcherOptions.getDefaultProfileOptions(),
  // );
}

class NoopReportModeAction extends ReportModeAction {
  @override
  void onActionConfirmed(Report report) {}

  @override
  void onActionRejected(Report report) {}
}

/// This called by runAppCatchError
void registerErrorHandlers() {}

/// Rethrows [error] with a stacktrace that is the combination of [stackTrace]
/// and [StackTrace.current].  (Stolen from riverpod)
void throwErrorWithCombinedStackTrace(Object error, StackTrace stackTrace) {
  final chain = Chain([
    Trace.current(),
    ...Chain.forTrace(stackTrace).traces,
  ]).foldFrames((frame) => frame.package == 'riverpod');

  Error.throwWithStackTrace(error, chain.toTrace().vmTrace);
}

class AppErrorHandler {
  static final AppErrorHandler _instance = AppErrorHandler._internal();
  factory AppErrorHandler() => _instance;
  AppErrorHandler._internal();

  final Logger _logger = Logger('AppErrorHandler');
  late String _logFilePath;

  Future<void> initialize() async {
    // Set up logging
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      print('${record.level.name}: ${record.time}: ${record.message}');
      _writeToLogFile(
          '${record.level.name}: ${record.time}: ${record.message}');
    });

    // Set up error handling
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      logError('Flutter Error', details.exception, details.stack);
    };

    // Handle errors that occur during asynchronous execution
    PlatformDispatcher.instance.onError = (error, stack) {
      logError('Async Error', error, stack);
      return true;
    };

    // Initialize log file
    final directory = await getApplicationDocumentsDirectory();
    _logFilePath = '${directory.path}/app_logs.txt';
  }

  void logError(String type, dynamic error, StackTrace? stackTrace) {
    _logger.severe('$type: $error', error, stackTrace);
  }

  Future<void> _writeToLogFile(String log) async {
    final file = File(_logFilePath);
    await file.writeAsString('$log\n', mode: FileMode.append);
  }

  Future<String> getLogContents() async {
    final file = File(_logFilePath);
    if (await file.exists()) {
      return await file.readAsString();
    }
    return 'No logs found.';
  }

  void clearLogs() async {
    final file = File(_logFilePath);
    if (await file.exists()) {
      await file.delete();
    }
  }
}

class WebErrorHandler {
  static final WebErrorHandler _instance = WebErrorHandler._internal();
  factory WebErrorHandler() => _instance;
  WebErrorHandler._internal();

  final Logger _logger = Logger('WebErrorHandler');
  final List<String> _logs = [];

  void initialize() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      final log = '${record.level.name}: ${record.time}: ${record.message}';
      print(log);
      _logs.add(log);
    });

    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      logError('Flutter Error', details.exception, details.stack);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      logError('Async Error', error, stack);
      return true;
    };
  }

  void logError(String type, dynamic error, StackTrace? stackTrace) {
    _logger.severe('$type: $error', error, stackTrace);
  }

  List<String> getLogs() => List.from(_logs);

  void clearLogs() => _logs.clear();
}

class ErrorPage extends StatelessWidget {
  final String error;

  const ErrorPage({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('An error occurred: $error'),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
