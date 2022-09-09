import 'package:flutter/material.dart';
import 'package:goodhouse/common/utils/http.dart';
import 'package:goodhouse/pages/home/info/index.dart';
import 'package:goodhouse/pages/home/tab_index/index_navigator.dart';
import 'package:goodhouse/pages/home/tab_index/index_recommend.dart';
import 'package:goodhouse/pages/home/tab_index/index_recommend_data.dart';
import 'package:goodhouse/widget/common_swiper.dart';
import 'package:goodhouse/widget/search_bar/index.dart';
import 'package:goodhouse/common/entities/indexRecommendData.dart';

class TabIndex extends StatefulWidget {
  const TabIndex({Key? key}) : super(key: key);

  @override
  State<TabIndex> createState() => _TabIndexState();
}

class _TabIndexState extends State<TabIndex> {
  List<IndexRecommendItem> indexRecommendData = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    List<dynamic> response =
        await HttpUtil().get('http://120.24.218.71:1337/Index-recommend-items');
    indexRecommendData =
        response.map((item) => IndexRecommendData.fromJson(item)).toList();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchBar(
          shwoLocation: true,
          onSearch: () {
            Navigator.of(context).pushNamed('search');
          },
        ),
        // title: Text('fkdsj'),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          CommonSwiper(),
          IndexNavigator(),
          IndexRecomment(dataList: indexRecommendData),
          Info(),
          // IndexNavigatorItem(title, imageUrl, onTap)
          // Text("这里是内容区"),
        ],
      ),
    );
  }
}
