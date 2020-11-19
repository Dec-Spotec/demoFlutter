import 'package:flutter/material.dart';
import 'package:telepment_project/net/base_bean.dart';

class UserDataVM extends ChangeNotifier {
  static var instance = UserDataVM._();
  UserData _data = UserData({});
  UserData get data => _data;
  bool get isLogin {
    return _data?.token != null;
  }

  UserDataVM._();
  void updateToken(String token) {
    _data.token = token;
    notifyListeners();
  }

  void resetUserData(Map<String, dynamic> data) {
    _data = UserData(data);
    notifyListeners();
  }

  void updateUserData(Map<String, dynamic> data) {
    _data.update(data);
    notifyListeners();
  }

  void requestData() {}
}

class UserData extends BaseBean {
  String name;
  String token;

  UserData(Map<String, dynamic> json) : super(json) {
    name = json["name"]?.toString();
    token = json["token"]?.toString();
  }

  void update(Map<String, dynamic> json) {
    name = json["name"] ?? name;
    token = json["token"] ?? token;
  }

  @override
  Map<String, dynamic> get json {
    return {"name": name, "token": token};
  }
}
