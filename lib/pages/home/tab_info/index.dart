import 'package:flutter/material.dart';
import 'package:goodhouse/common/utils/http.dart';
import 'package:goodhouse/pages/home/tab_info/data.dart';
import 'package:goodhouse/pages/home/tab_info/item_widget.dart';
import 'package:goodhouse/widget/search_bar/index.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class TabInfo extends StatefulWidget {
  const TabInfo({Key? key}) : super(key: key);

  @override
  _TabInfoState createState() => _TabInfoState();
}

class _TabInfoState extends State<TabInfo> {
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
        backgroundColor: Colors.white,
      ),
      // body: ListView(
      //   children: [
      //     Padding(padding: EdgeInsets.only(top: 8)),
      //     Info(),
      //   ],
      // ),
      body: NewInfo(),
    );
  }
}

class NewInfo extends StatefulWidget {
  const NewInfo({
    Key? key,
  }) : super(key: key);

  @override
  State<NewInfo> createState() => _NewInfoState();
}

class _NewInfoState extends State<NewInfo> {
  int pageSize = 8;
  List<dynamic> dataList = [];
  int pageIndex = 0;
  bool noData = false;

  Future getData() async {
    List<dynamic> response =
        // await HttpUtil().get('http://120.24.218.71:8887/newList/2/$pageIndex');
        await HttpUtil().get(
            'http://120.24.218.71:1337/info-items?_start=${pageIndex * pageSize}&_limit=$pageSize');
    if (response.isEmpty) {
      noData = true;
    }
    dataList.addAll(response);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.resetNoData();
    pageIndex = 0;
    dataList = [];
    noData = false;
    await getData();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    pageIndex++;
    await getData();
    if (noData == true) {
      _refreshController.loadNoData();
    } else {
      _refreshController.loadComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView.builder(
        itemBuilder: (c, i) => Center(
            child: ItemWidget(data: InfoItem.fromJson(dataList[i]))),
        itemExtent: 100.0,
        itemCount: dataList.length,
      ),
    );
  }
}
