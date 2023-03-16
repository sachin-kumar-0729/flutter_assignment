import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/log.dart';
import '../repository/home_repository.dart';
import '../state/home_state.dart';

class HomeController extends StateNotifier<HomeState> {
  final HomeRepository _homeRepository;

  HomeController(this._homeRepository) : super(const HomeInitial());

  Future<void> rocketsListCall() async {
    try {
      state = const GetRocketsListLoading();
      final response = await _homeRepository.rocketsListCall();

      state = GetRocketsListSuccess(response);
    } catch (exception) {
      Log.v("$exception");
      state = GetRocketsListError("$exception");
    }
  }

  Future<void> rocketsDetailsCall({required String id}) async {
    try {
      state = const GetRocketsDetailsLoading();
      final response = await _homeRepository.rocketsDetailsCall(id: id);

      state = GetRocketsDetailsSuccess(response);
    } catch (exception) {
      Log.v("$exception");
      state = GetRocketsDetailsError("$exception");
    }
  }
}
