import 'package:flutter/material.dart';
import 'package:goodhouse/application.dart';
import 'package:goodhouse/global.dart';

void main() async {
  await Global.init();
  runApp(Application());
}
