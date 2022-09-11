import 'package:flutter/material.dart';
import 'package:goodhouse/common/values/colors.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  /// 页头标题
  Widget _buildPageHeadTitle() {
    return Container(
      margin: EdgeInsets.only(top: (60 + 44.0)), // 顶部系统栏 44px
      child: Text(
        "租房首月5折优惠!",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.primaryText,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
          fontSize: (24),
          height: 1,
        ),
      ),
    );
  }

  /// 页头说明
  Widget _buildPageHeaderDetail() {
    return Container(
      width: (242),
      height: (70),
      margin: EdgeInsets.only(top: (14)),
      child: Text(
        "什么样的室内装修才适合你？",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.primaryText,
          fontFamily: "Avenir",
          fontWeight: FontWeight.normal,
          fontSize: (16),
          height: 1.3,
        ),
      ),
    );
  }

  /// 特性说明
  /// 宽度 80 + 20 + 195 = 295
  Widget _buildFeatureItem(String imageName, String intro, double marginTop) {
    return Container(
      width: (295),
      height: (80),
      margin: EdgeInsets.only(top: (marginTop)),
      child: Row(
        children: [
          Container(
            width: (80),
            height: (80),
            child: Image.asset(
              "assets/images/$imageName.png",
              fit: BoxFit.none,
            ),
          ),
          Spacer(),
          Container(
            width: (195),
            child: Text(
              intro,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: AppColors.primaryText,
                fontFamily: "Avenir",
                fontWeight: FontWeight.normal,
                fontSize: (16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 开始按钮
  Widget _buildStartButton(BuildContext context) {
    return Container(
      width: (295),
      height: (44),
      margin: EdgeInsets.only(bottom: (20)),
      child: FlatButton(
        color: AppColors.primaryElement,
        textColor: AppColors.primaryElementText,
        child: Text("马上开始"),
        shape: RoundedRectangleBorder(),
        onPressed: () {
          Navigator.of(context).pushNamed('/home');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            _buildPageHeadTitle(),
            _buildPageHeaderDetail(),
            _buildFeatureItem(
              "feature-1",
              "租房首月5折优惠",
              86,
            ),
            _buildFeatureItem(
              "feature-2",
              "租房装修新选择",
              40,
            ),
            _buildFeatureItem(
              "feature-3",
              "选房中的小窍门",
              40,
            ),
            Spacer(),
            _buildStartButton(context),
          ],
        ),
      ),
    );
  }
}
