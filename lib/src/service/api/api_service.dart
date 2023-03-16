import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'environment.dart';

final dioProvider = Provider.autoDispose<Dio>((ref) {
  final dio = ApiService().init();
  return dio;
});

class ApiService {
  //static const _timeout = 30000;
  late Dio dio;

  Environment _env = _Prod();

  Environment get env => _env;

  Dio init() {
    
    Map<String,dynamic> headers = {"Cookie": "access_token=}"};

    final options = BaseOptions(
        baseUrl: _env.baseUrl,
       // connectTimeout: _timeout,
       //receiveTimeout: _timeout,
        headers: headers );
    dio = Dio(options);
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
          responseBody: true,
          requestHeader: false,
          responseHeader: false,
          request: true,
          requestBody: true));
    }

    return dio;
  }

  void setEnvironment(EnvironmentType type) {
    log("Setting environment to $type");
    switch (type) {
      case EnvironmentType.dev:
        _env = _Dev();
        break;
      default:
        _env = _Prod();
    }
  }
}

class _Prod extends Environment {
  @override
  EnvironmentType get type => EnvironmentType.prod;

  @override
  String get baseUrl => "https://api.spacexdata.com/v4/";

  //TODO: add your api key here
  @override
  String get apiKey => "For api key";
}

class _Dev extends Environment {
  @override
  EnvironmentType get type => EnvironmentType.dev;

  @override
  String get baseUrl => "https://api.spacexdata.com/v4/";

  //TODO: add your api key here
  @override
  String get apiKey => "For api key";
}
