import 'package:flutter/material.dart';
import 'package:goodhouse/common/utils/http.dart';
import 'package:goodhouse/utils/common_toast.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool showPassword = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  var registerData;

  void onRegister(name, pwd, confirm) async {
    if (name == '' || pwd == '' || confirm == '') {
      CommonToast.showToast('账号密码不能为空');
      return;
    }
    if (pwd != confirm) {
      CommonToast.showToast('密码不一致');
      return;
    }

    var response =
        await HttpUtil().post('/register', data: {"user": name, "pwd": pwd});
    if (response['error'] == 0) {
      CommonToast.showToast('注册失败，请稍后再试');
      return;
    }
    CommonToast.showToast('注册成功');
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("注册"),
      ),
      // child: PageContent(name: "登录"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
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
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: confirmController,
                obscureText: !showPassword,
                decoration: InputDecoration(
                  labelText: "确认密码",
                  hintText: "请再次输入密码",
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text("注册"),
                  onPressed: () {
                    onRegister(nameController.text, pwdController.text,
                        confirmController.text);
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('已有账号，'),
                  TextButton(
                    child: Text(
                      '去登录～',
                      style: TextStyle(color: Colors.teal),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'login');
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
