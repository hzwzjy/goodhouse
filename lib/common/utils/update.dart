import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:goodhouse/common/apis/apis.dart';
import 'package:goodhouse/common/entities/entities.dart';
import 'package:goodhouse/common/widgets/widgets.dart';
import 'package:goodhouse/global.dart';
import 'package:path_provider/path_provider.dart';
import 'package:r_upgrade/r_upgrade.dart';

/// app 升级
class AppUpdateUtil {
  static AppUpdateUtil _instance = AppUpdateUtil._internal();
  factory AppUpdateUtil() => _instance;

  late BuildContext _context;
  late AppUpdateResponseEntity _appUpdateInfo;

  AppUpdateUtil._internal();

  /// 获取更新信息
  Future run(BuildContext context) async {
    _context = context;

    // 提交 设备类型、发行渠道、架构、机型
    AppUpdateRequestEntity requestDeviceInfo = AppUpdateRequestEntity(
      device: Global.isIOS == true ? "ios" : "android",
      channel: Global.channel,
      architecture: Global.isIOS == true
          ? Global.iosDeviceInfo.utsname.machine
          : Global.androidDeviceInfo.device,
      model: Global.isIOS == true
          ? Global.iosDeviceInfo.name
          : Global.androidDeviceInfo.brand,
    );
    _appUpdateInfo =
        await AppApi.update(context: context, params: requestDeviceInfo);

    // _appUpdateInfo = AppUpdateResponseEntity(
    //   latestVersion: '1.0.3',
    //   latestDescription: '1 加入了自动升级功能 2 动态授权存储权限 3 IOS 端支持 swift 语言',
    //   shopUrl: 'https://apps.apple.com/cn/app/id414478124',
    //   fileUrl:
    //       'http://120.24.218.71/app-release.apk', // https://www.pgyer.com/iyNY
    // );
    _runAppUpdate();
  }

  /// 检查是否有新版
  Future _runAppUpdate() async {
    // 比较版本
    final isNewVersion =
        (_appUpdateInfo.latestVersion!.compareTo(Global.packageInfo.version) ==
            1);

    // 安装
    if (isNewVersion == true) {
      _appUpdateConformDialog(() async {
        Navigator.of(_context).pop();
        if (Global.isIOS == true) {
          // 去苹果店
          await RUpgrade.upgradeFromAppStore(
            _appUpdateInfo.shopUrl!.replaceAll(
                'https://apps.apple.com/cn/app/id',
                ''), // 您的AppId,例如:微信的AppId:414478124
          );
        } else {
          // apk 下载安装
          toastInfo(msg: "开始下载升级包");
          _downloadAPKAndSetup(_appUpdateInfo.fileUrl!);
        }
      });
    }
  }

  /// 下载文件 & 安装
  Future _downloadAPKAndSetup(String fileUrl) async {
    // 下载
    Directory? externalDir = await getExternalStorageDirectory();
    String fullPath = externalDir!.path + "/release.apk";

    Dio dio = Dio(BaseOptions(
        responseType: ResponseType.bytes,
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        }));
    Response response = await dio.get(
      fileUrl,
    );

    File file = File(fullPath);
    var raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();

    // 安装
    await RUpgrade.installByPath(fullPath);
  }

  /// 升级确认对话框
  void _appUpdateConformDialog(onPressed) {
    showCupertinoModalPopup<void>(
      context: _context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text("发现新版本 ${_appUpdateInfo.latestVersion}"),
        content: Text(_appUpdateInfo.latestDescription!),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('取消'),
          ),
          CupertinoDialogAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as deletion, and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: onPressed,
            child: const Text('同意'),
          ),
        ],
      ),
    );
  }
}
