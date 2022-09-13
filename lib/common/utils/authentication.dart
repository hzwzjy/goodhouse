import 'dart:async';

import 'package:flutter/material.dart';
import 'package:goodhouse/common/utils/storage.dart';
import 'package:goodhouse/common/values/storage.dart';
import 'package:goodhouse/global.dart';
import 'package:goodhouse/routes.dart';

/// 检查是否有 token
Future<bool> isAuthenticated() async {
  var profileJSON = StorageUtil().getJSON(STORAGE_USER_PROFILE_KEY);
  return profileJSON != null ? true : false;
}

/// 删除缓存 token
Future deleteAuthentication() async {
  await StorageUtil().remove(STORAGE_USER_PROFILE_KEY);
  Global.profile = null;
}

/// 重新登录
Future goHomePage(BuildContext context) async {
  await deleteAuthentication();
  Navigator.of(context).pushNamedAndRemoveUntil(Routes.home, (route) => false);
}
