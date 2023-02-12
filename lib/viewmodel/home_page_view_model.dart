import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

part 'home_page_view_model.g.dart';

class HomePageViewModel = _HomePageViewModel with _$HomePageViewModel;

abstract class _HomePageViewModel with Store {
  static const yahooFinanceUrl =
      'https://query2.finance.yahoo.com/v8/finance/chart/PETR4.SA';

  static final dio = Dio();

  @readonly
  List<Indicator>? _indicators;

  @readonly
  HomePageStates _status = HomePageStates.idle;

  void dispose() {}

  @action
  Future<void> getData() async {
    _status = HomePageStates.loading;
    if (_indicators != null) {
      _indicators!.clear();
    }
    try {
      final response = await dio.get(yahooFinanceUrl);
      final result = response.data['chart']['result'][0];
      final timestamps = result['timestamp'];
      final openValues = result['indicators']['quote'][0]['open'];
      List<Indicator> localIndicator = [];
      for (int i = 0; i < 30; i++) {
        localIndicator.add(
          Indicator(
            day: i + 2,
            timestamp:
                DateTime.fromMillisecondsSinceEpoch(timestamps![i] * 1000),
            openValue: openValues![i],
            dMinusOneVariation: (i != 0)
                ? _getVariation(
                    openValues![i - 1],
                    openValues![i],
                  )
                : null,
            dOneVariation: (i != 0)
                ? _getVariation(
                    openValues![0],
                    openValues![i],
                  )
                : null,
          ),
        );
      }

      _indicators = localIndicator;

      _status = HomePageStates.success;
    } catch (e) {
      if (kDebugMode) print(e);
      _status = HomePageStates.error;
    }
  }
}

double _getVariation(double priorValue, double currentValue) {
  return (currentValue - priorValue) * 100 / priorValue;
}

enum HomePageStates {
  idle,
  loading,
  success,
  error,
}

class Indicator {
  final int day;
  final DateTime timestamp;
  final double openValue;
  final double? dMinusOneVariation;
  final double? dOneVariation;

  Indicator({
    required this.day,
    required this.timestamp,
    required this.openValue,
    this.dMinusOneVariation,
    this.dOneVariation,
  });
}
