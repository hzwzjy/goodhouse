import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:goodhouse/common/entities/registerData.dart';
import 'package:goodhouse/common/provider/provider.dart';
import 'package:goodhouse/common/utils/storage.dart';
import 'package:goodhouse/common/values/storage.dart';

/// 全局配置
class Global {
  /// 用户配置
  static late RegisterData profile;

  /// 是否 ios
  static bool isIOS = Platform.isIOS;

  /// android 设备信息
  static late AndroidDeviceInfo androidDeviceInfo;

  /// ios 设备信息
  static late IosDeviceInfo iosDeviceInfo;

  /// 是否第一次打开
  static bool isFirstOpen = false;

  /// 是否离线登录
  static bool isOfflineLogin = false;

  /// 应用状态,
  static AppState appState = AppState();

  /// init
  static Future init() async {
    // 运行初始
    WidgetsFlutterBinding.ensureInitialized();
    // 读取设备信息
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Global.isIOS) {
      Global.iosDeviceInfo = await deviceInfoPlugin.iosInfo;
    } else {
      Global.androidDeviceInfo = await deviceInfoPlugin.androidInfo;
    }

    // 工具初始
    await StorageUtil.init();

    // 读取设备第一次打开
    isFirstOpen = !StorageUtil().getBool(STORAGE_DEVICE_ALREADY_OPEN_KEY);
    if (isFirstOpen) {
      StorageUtil().setBool(STORAGE_DEVICE_ALREADY_OPEN_KEY, true);
    }

    // 读取离线用户信息
    var _profileJSON = StorageUtil().getJSON(STORAGE_USER_PROFILE_KEY);
    if (_profileJSON != null) {
      profile = RegisterData.fromJson(_profileJSON);
      isOfflineLogin = true;
    }
  }

  // 持久化 用户信息
  static Future<bool> saveProfile(RegisterData userResponse) {
    profile = userResponse;
    return StorageUtil()
        .setJSON(STORAGE_USER_PROFILE_KEY, userResponse.toJson());
  }
}
