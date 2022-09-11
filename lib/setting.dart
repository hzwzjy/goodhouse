import 'package:flutter/material.dart';
import 'package:goodhouse/common/utils/storage.dart';
import 'package:goodhouse/common/values/storage.dart';
import 'package:goodhouse/scoped_model/room_filter.dart';
import 'package:goodhouse/utils/common_toast.dart';
import 'package:goodhouse/utils/scoped_model_helper.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
      ),
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              ScopedModelHelper.getModel<FilterBarModel>(context).clearUserInfo();
              StorageUtil().remove(STORAGE_USER_PROFILE_KEY);
              CommonToast.showToast('已经退出登录');
              Navigator.of(context).pushNamed('/home');
            },
            child: Text(
              '退出登录',
              style: TextStyle(),
            ),
          )
        ],
      ),
    );
  }
}
