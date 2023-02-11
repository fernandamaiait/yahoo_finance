import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DChart extends StatelessWidget {
  const DChart({super.key});

  @override
  Widget build(BuildContext context) {
    return DChartTime(
      chartRender: DRenderLine(),
      measureLabel: (value) => '${value}k',
      domainLabel: (dateTime) {
        return DateFormat('d MMM yy').format(dateTime!);
      },
      groupData: [
        DChartTimeGroup(
          id: 'Keyboard',
          color: Colors.blue,
          data: [
            DChartTimeData(time: DateTime(2023, 2, 1), value: 29),
            DChartTimeData(time: DateTime(2023, 2, 2), value: 73),
            DChartTimeData(time: DateTime(2023, 2, 4), value: 23),
            DChartTimeData(time: DateTime(2023, 2, 8), value: 56),
            DChartTimeData(time: DateTime(2023, 2, 9), value: 32),
            DChartTimeData(time: DateTime(2023, 2, 10), value: 21),
            DChartTimeData(time: DateTime(2023, 2, 12), value: 76),
            DChartTimeData(time: DateTime(2023, 2, 18), value: 91),
            DChartTimeData(time: DateTime(2023, 2, 20), value: 17),
          ],
        ),
      ],
    );
  }
}
