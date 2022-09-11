import 'package:goodhouse/common/entities/registerData.dart';
import 'package:goodhouse/common/utils/storage.dart';
import 'package:goodhouse/common/values/storage.dart';
import 'package:goodhouse/pages/home/tab_search/filter_bar/data.dart';

import 'package:scoped_model/scoped_model.dart';

class FilterBarModel extends Model {
  List<GeneralType> _roomTypeList = [];
  List<GeneralType> _orientedList = [];
  List<GeneralType> floorList = [];

  RegisterData userInfo =
      RegisterData.fromJson(StorageUtil().getJSON(STORAGE_USER_PROFILE_KEY) ??
          {
            "user_id": 0,
            "user_name": '',
            "user_pwd": '',
            "register_time": 0,
            "user_status": 0,
          });

  clearUserInfo() {
    userInfo = RegisterData.fromJson({
      "user_id": 0,
      "user_name": '',
      "user_pwd": '',
      "register_time": 0,
      "user_status": 0,
    });
  }

  Set<String> _selectedList = Set<String>();

  Map<String, List<GeneralType>> get dataList {
    var result = Map<String, List<GeneralType>>();
    result['roomTypeList'] = _roomTypeList;
    result['orientedList'] = _orientedList;
    result['roomTypeList'] = floorList;
    return result;
  }

  set dataList(Map<String, List<GeneralType>> data) {
    // _roomTypeList = data['roomTypeList'];
    // _orientedList = data['orientedList'];
    // floorList = data['floorList'];
    notifyListeners();
  }

  Set<String> get selectedList {
    return _selectedList;
  }

  selectedListTroggleItem(String data) {
    if (_selectedList.contains(data)) {
      _selectedList.remove(data);
    } else {
      _selectedList.add(data);
    }
  }

  notifyListeners();
}
