import 'package:flutter/material.dart';
import 'package:goodhouse/common/utils/utils.dart';
import 'package:goodhouse/global.dart';
import 'package:goodhouse/pages/home/index.dart';
import 'package:goodhouse/pages/welcome/welcome.dart';
import 'package:permission_handler/permission_handler.dart';

class AppUpdate extends StatefulWidget {
  const AppUpdate({Key? key}) : super(key: key);

  @override
  _AppUpdateState createState() => _AppUpdateState();
}

class _AppUpdateState extends State<AppUpdate> {
  @override
  void initState() {
    super.initState();

    if (Global.isRelease == true) {
      doAppUpdate();
    } else {
      doAppUpdate();
    }
  }

  Future doAppUpdate() async {
    await Future.delayed(Duration(seconds: 3), () async {
      if (Global.isIOS == false &&
          await Permission.storage.isGranted == false) {
        await [Permission.storage].request();
      }
      if (await Permission.storage.isGranted) {
        AppUpdateUtil().run(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Global.isFirstOpen ? WelcomePage() : HomePage();
  }
}
