import 'package:flutter/material.dart';
import 'package:goodhouse/common/entities/entities.dart';
import 'package:goodhouse/common/utils/utils.dart';

/// 系统相关
class AppApi {
  /// 获取最新版本信息
  static Future<AppUpdateResponseEntity> update({
    required BuildContext context,
    AppUpdateRequestEntity? params,
  }) async {
    var response = await HttpUtil().get(
      'http://120.24.218.71:1337/app-updates',
      context: context,
    );
    // var response = await HttpUtil().post(
    //   'http://120.24.218.71:1337/app-updates',
    //   context: context,
    //   data: params,
    // );
    return AppUpdateResponseEntity.fromJson(response[0]);
  }
}
