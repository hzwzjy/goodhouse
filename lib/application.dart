import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:goodhouse/global.dart';
import 'package:goodhouse/pages/home/index.dart';
import 'package:goodhouse/pages/welcome/welcome.dart';
import 'package:goodhouse/routes.dart';
import 'package:goodhouse/scoped_model/room_filter.dart';
import 'package:scoped_model/scoped_model.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    return ScopedModel<FilterBarModel>(
      model: FilterBarModel(),
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.teal),
        onGenerateRoute: router.generator,
        debugShowCheckedModeBanner: false,
        home: Global.isFirstOpen ? WelcomePage() : HomePage(),
      ),
    );
  }
}
