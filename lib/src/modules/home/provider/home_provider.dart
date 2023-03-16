import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../service/api/api_service.dart';
import '../controller/home_controller.dart';
import '../repository/home_repository.dart';

final homeRepositoryProvider = Provider.autoDispose<HomeRepository>(
  (ref) {
    debugPrint("Home provider in action......................");
    final api = ref.watch(dioProvider);
    return HomeRepository(api: api);
  },
);

final homeStateProvider = StateNotifierProvider.autoDispose(
  (ref) => HomeController(ref.watch(homeRepositoryProvider)),
);
