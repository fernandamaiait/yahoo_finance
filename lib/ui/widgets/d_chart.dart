import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DChart extends StatelessWidget {
  const DChart({
    required this.data,
    super.key,
  });

  final List<DChartTimeData> data;

  @override
  Widget build(BuildContext context) {
    return DChartTime(
      startDate: data.first.time,
      endDate: data.last.time,
      startFromZero: false,
      chartRender: DRenderLine(),
      measureLabel: (value) => value!.toStringAsFixed(2),
      showDomainLine: true,
      showMeasureLine: true,
      domainLabel: (dateTime) {
        return DateFormat('dd/MM/yyyy').format(dateTime!);
      },
      groupData: [
        DChartTimeGroup(
          id: '',
          color: Theme.of(context).primaryColor,
          data: data,
        ),
      ],
    );
  }
}
