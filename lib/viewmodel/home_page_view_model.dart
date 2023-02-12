import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:yahoo_finance/ui/consts.dart';
import 'package:d_chart/d_chart.dart';

part 'home_page_view_model.g.dart';

class HomePageViewModel = _HomePageViewModel with _$HomePageViewModel;

abstract class _HomePageViewModel with Store {
  static final dio = Dio();

  @readonly
  String? _currency;

  @readonly
  List<Indicator>? _indicators = [];

  @readonly
  List<DChartTimeData>? _chartData = [];

  @readonly
  String _searchString = '';

  @readonly
  HomePageStates _status = HomePageStates.idle;

  void dispose() {}

  @action
  Future<void> getData(String searchString) async {
    _status = HomePageStates.loading;
    _searchString = searchString.toUpperCase();

    final period1 = ((DateTime.now()
                .subtract(const Duration(days: 30))
                .toUtc()
                .millisecondsSinceEpoch) /
            1000)
        .round();

    _indicators!.clear();
    _chartData!.clear();

    try {
      final url =
          '$YAHOO_FINANCE_URL$_searchString?period1=$period1&period2=9999999999&interval=1d';
      final response = await dio.get(url);
      final result = response.data['chart']['result'][0];
      _currency = result['meta']['currency'];
      final timestamps = result['timestamp'];
      final openValues = result['indicators']['quote'][0]['open'];

      for (int i = 0; (i < 30 && i < timestamps.length); i++) {
        _chartData!.add(
          DChartTimeData(
              time: DateTime.fromMillisecondsSinceEpoch(timestamps![i] * 1000),
              value: openValues![i]),
        );
        _indicators!.add(
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
