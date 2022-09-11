

import 'package:flutter/material.dart';
import 'package:goodhouse/common/entities/registerData.dart';
import 'package:goodhouse/common/utils/http.dart';
import 'package:goodhouse/global.dart';
import 'package:goodhouse/scoped_model/room_filter.dart';
import 'package:goodhouse/utils/common_toast.dart';
import 'package:goodhouse/utils/scoped_model_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showPassword = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  void onLogin(name, pwd) async {
    if (name == '' || pwd == '') {
      CommonToast.showToast('账号密码不能为空');
      return;
    }

    Map<String, dynamic> response =
        await HttpUtil().post('/login', data: {"user": name, "pwd": pwd});
    if (response.isEmpty) {
      CommonToast.showToast('账号或密码错误');
      return;
    }

    RegisterData registerData = RegisterData.fromJson(response);
    ScopedModelHelper.getModel<FilterBarModel>(context).userInfo = registerData;
        
    Global.saveProfile(registerData);

    CommonToast.showToast('登录成功');
    Navigator.of(context).pushReplacementNamed('/home');
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
      ),
      // child: PageContent(name: "登录"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: 24,
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "账号",
                  hintText: "请输入账号",
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: pwdController,
                obscureText: !showPassword,
                decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "请输入密码",
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                        showPassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              GestureDetector(
                child: Container(
                  width: double.infinity,
                  child: Text(
                    "找回密码",
                    style: TextStyle(color: Colors.blue),
                    textAlign: TextAlign.right,
                  ),
                ),
                onTap: () {
                  print("找回密码被点击");
                },
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text("登录"),
                  onPressed: () {
                    onLogin(
                      nameController.text,
                      pwdController.text,
                    );
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text("注册"),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'register');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
