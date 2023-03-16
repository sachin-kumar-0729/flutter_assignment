import 'package:flutter_application/src/modules/home/model/response/rocket_details_response.dart';
import 'package:flutter_application/src/modules/home/model/response/rockets_response.dart';



abstract class HomeState {
  const HomeState();
}

/////////Initial State////////////////////
class HomeInitial extends HomeState {
  const HomeInitial();
}

////////Get Rockets list state ////////////
class GetRocketsListLoading extends HomeState {
  const GetRocketsListLoading();
}

class GetRocketsListSuccess extends HomeState {
  final List<RocketResponse>? response;

  const GetRocketsListSuccess(this.response);
}

class GetRocketsListError extends HomeState {
  final String error;

  const GetRocketsListError(this.error);
}

///Get Rockets Details state
class GetRocketsDetailsLoading extends HomeState {
  const GetRocketsDetailsLoading();
}

class GetRocketsDetailsSuccess extends HomeState {
  final RocketDetailsResponse? response;

  const GetRocketsDetailsSuccess(this.response);
}

class GetRocketsDetailsError extends HomeState {
  final String error;

  const GetRocketsDetailsError(this.error);
}




