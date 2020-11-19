import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:telepment_project/net/net_config.dart';

import 'base_bean.dart';

class Net {
  static final instance = Net._();
  Dio _dio;
  Net._() {
    _dio = Dio();
    _dio.options.connectTimeout = 10000;
    _dio.options.receiveTimeout = 100000;
    _configRequest();
  }

  void _configRequest(
      {Map<String, String> headers(),
      void checkResponeError(dynamic data),
      dynamic mapRespone(Response respone)}) {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (request) {
      debugPrint(
          "start request is ${request.baseUrl} ${request.path} ${request.queryParameters}");
      if (headers is Function) {
        request.headers = headers();
      }
      return request;
    }, onResponse: (respone) {
      debugPrint("start request is ${respone.realUri} ${respone.data}");
      if (checkResponeError != null) {
        checkResponeError(respone.data);
      }
      if (mapRespone != null) {
        return mapRespone(respone);
      } else {
        return respone;
      }
    }, onError: (e) {
      debugPrint("error :$e");
      return e;
    }));
  }

  void config(
      {BaseOptions options,
      Map<String, String> headers(),
      void checkResponeError(dynamic data),
      dynamic mapRespone(Response respone)}) {
    if (options != null) {
      _dio = Dio(options);
    }
    _configRequest(headers: headers, checkResponeError: checkResponeError);
  }

  get(String url,
      {Map<String, dynamic> header, Map<String, dynamic> params}) async {
    var respone = await _dio.get(url, queryParameters: params);
    return respone.data;
  }

  post(String url,
      {Map<String, dynamic> header, Map<String, dynamic> params}) async {
    var respone = await _dio.post(url, data: params);
    return respone.data;
  }

  postFormData(url, {Map<String, dynamic> header, FormData params}) async {
    var respone = await _dio.post(url, data: params);
    return respone.data;
  }

  download(String url, String savePath,
      {Map<String, dynamic> header, FormData params}) async {
    var respone = await _dio.download(url, savePath, data: params);
    return respone.data;
  }
}
