import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

part 'home_page_view_model.g.dart';

class HomePageViewModel = _HomePageViewModel with _$HomePageViewModel;

abstract class _HomePageViewModel with Store {
  static const yahooFinanceUrl =
      'https://query2.finance.yahoo.com/v8/finance/chart/PETR4.SA';

  @readonly
  List<dynamic>? _openValues;

  @readonly
  List<dynamic>? _timestamps;

  @readonly
  HomePageStates _status = HomePageStates.idle;

  void dispose() {}

  @action
  Future<void> getData() async {
    _status = HomePageStates.loading;

    try {
      var dio = Dio();
      final response = await dio.get(yahooFinanceUrl);
      final result = response.data['chart']['result'][0];
      _timestamps = result['timestamp'];
      _openValues = result['indicators']['quote'][0]['open'];
      _status = HomePageStates.success;
    } catch (e) {
      if (kDebugMode) print(e);
      _status = HomePageStates.error;
    }
  }
}

enum HomePageStates {
  idle,
  loading,
  success,
  error,
}
