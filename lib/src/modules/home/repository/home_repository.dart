import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_application/src/modules/home/model/response/rocket_details_response.dart';
import 'package:flutter_application/src/modules/home/model/response/rockets_response.dart';
import 'package:flutter_application/src/service/api/api_constant.dart';
import 'package:flutter_application/src/service/api/api_exception.dart';
import 'package:flutter_application/src/service/api/api_service.dart';
import '../../../utils/constants/Strings.dart';
import '../../../utils/log.dart';

class HomeRepository {
  final Dio api;

  HomeRepository({required this.api});

  Future<List<RocketResponse>> rocketsListCall() async {
    try {
      final api = ApiService().init();
      final apiResponse =
          await api.get(ApiConstant.roleList);
      if (apiResponse.statusCode! >= 200 && apiResponse.statusCode! <= 300) {
        Log.v("api response ==========${apiResponse.data}");

        List<RocketResponse> rocketList = List<RocketResponse>.from(
            apiResponse.data.map((model) => RocketResponse.fromJson(model)));

        Log.v(" rocketsData list......................${rocketList.length}");
        return rocketList;
      } else {
        throw ApiException(
            message: Strings.internalServerError,
            statusCode: apiResponse.statusCode!);
      }
    } on SocketException {
      throw ApiException(message: Strings.internetNotAvailable);
    } on DioError catch (exception) {
      Log.v("HomeRepository exception $exception");
      throw ApiException(
          message: exception.response?.data['message'].toString() ??
              Strings.somethingWentWrong);
    }
  }

  Future<RocketDetailsResponse> rocketsDetailsCall({required String id}) async {
    try {
      final api = ApiService().init();
      final apiResponse =
          await api.get("https://api.spacexdata.com/v4/rockets/$id");
      if (apiResponse.statusCode! >= 200 && apiResponse.statusCode! <= 300) {
        Log.v("api Details response ==========${apiResponse.data}");
        final result =
            json.decode((apiResponse.toString())) as Map<String, dynamic>;
        final rocketDetailsList = RocketDetailsResponse.fromJson(result);
        return rocketDetailsList;
      } else {
        throw ApiException(
            message: Strings.internalServerError,
            statusCode: apiResponse.statusCode!);
      }
    } on SocketException {
      throw ApiException(message: Strings.internetNotAvailable);
    } on DioError catch (exception) {
      Log.v("HomeRepository exception  $exception");
      throw ApiException(
          message: exception.response?.data['message'].toString() ??
              Strings.somethingWentWrong);
    }
  }
}
