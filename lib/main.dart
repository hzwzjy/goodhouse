import 'dart:async';

import 'package:flutter/material.dart';
import 'package:goodhouse/application.dart';
import 'package:goodhouse/common/provider/app.dart';
import 'package:goodhouse/global.dart';
import 'package:provider/provider.dart';
import 'package:sentry/sentry.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    await Sentry.init(
      (options) {
        options.dsn =
            'https://564fda5fe0024a819905efd82d727274@o1381110.ingest.sentry.io/6760123';
      },
    );

    initApp();
  }, (Object exception, StackTrace stackTrace) async {
    await Sentry.captureException(exception, stackTrace: stackTrace);
  });
}

void initApp() async {
  await Global.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>.value(
          value: Global.appState,
        ),
      ],
      child: Consumer<AppState>(builder: (context, appState, _) {
        if (appState.isGrayFilter) {
          return ColorFiltered(
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.color),
            child: Application(),
          );
        } else {
          return Application();
        }
      }),
    ),
  );
}
