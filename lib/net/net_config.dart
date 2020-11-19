import 'package:dio/dio.dart';
import 'package:telepment_project/net/net.dart';

class ResponeError extends Error {
  int code = -1;
  String msg = "数据错误";
  ResponeError(this.code, this.msg);
}

class NetConfig {
  Map<String, String> headers() {
    return {"Content-type": "application/json", "Accept": "application/json"};
  }

  void checkError(dynamic data) {
    if (!(data is Map<String, dynamic>)) {
      throw ResponeError(-1, "数据格式不对");
    } else if (data["code"] != 200) {
      var code = int.parse("${data["code"]}");
      var msg = "${data["msg"]}";
      throw ResponeError(code, msg);
    }
  }

  dynamic mapRespone(Response respone) {
    return respone.data["data"];
  }

  void configNet() {
    Net.instance.config(
        headers: headers,
        checkResponeError: checkError,
        mapRespone: mapRespone);
  }
}
