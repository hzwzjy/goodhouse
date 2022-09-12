import 'package:flutter/material.dart';
import 'package:goodhouse/application.dart';
import 'package:goodhouse/common/provider/app.dart';
import 'package:goodhouse/global.dart';
import 'package:provider/provider.dart';

void main() async {
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
