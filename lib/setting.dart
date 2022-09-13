import 'package:flutter/material.dart';
import 'package:goodhouse/common/utils/utils.dart';
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
              CommonToast.showToast('已经退出登录');
              deleteAuthentication();
              goHomePage(context);
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
