import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:yahoo_finance/ui/widgets/d_chart.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static final currencyFormatter =
      NumberFormat.simpleCurrency(locale: 'pt_BR', decimalDigits: 2);

  @override
  Widget build(BuildContext context) {
    const timestamps = [
      '01/01/2021',
      '02/01/2021',
      '03/01/2021',
      '04/01/2021',
      // 1676034180,
      // 1676034240,
      // 1676034300,
      // 1676034360,
      // 1676034420,
    ];
    const openValues = [
      1.00,
      1.10,
      1.05,
      1.90,
      // 25.979999542236328,
      // 25.969999313354492,
      // 26.079999923706055,
      // 26.139999389648438,
      // 26.1200008392334,
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Guide - Yahoo Finance'),
      ),
      body: Column(
        children: [
          Text('D1: ${openValues[0]}'),
          _TableHeading(
            context,
            'Dia',
            'Data',
            'Valor',
            'Variação em relação D-1',
            'Variação em relação à primeira data',
          ),
          Table(
            //    border: _buildTableBorder(context),
            // columnWidths: const <int, TableColumnWidth>{
            //   0: FlexColumnWidth(),
            //   1: FlexColumnWidth(2),
            // },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: <TableRow>[
              for (int i = 1; i < timestamps.length; i++)
                _TableRow(
                  context,
                  (i + 1).toString(),
                  timestamps[i].toString(),
                  openValues[i].toString(),
                  i == 1
                      ? '---'
                      : ((openValues[i] * 100) / openValues[i - 1]).toString(),
                  i == 1
                      ? '---'
                      : ((openValues[i] * 100) / openValues[0]).toString(),
                ),
            ],
          ),
        ],
      ),
    );
  }

  // TableRow _buildTableRow(
  //   BuildContext context,
  //   columnOneText,
  //   columnTwoMarkdown, {
  //   TableCellVerticalAlignment columnOneVerticalAlignment = TableCellVerticalAlignment.top,
  //   TableCellVerticalAlignment columnTwoVerticalAlignment = TableCellVerticalAlignment.top,
  // }) {
  //   return TableRow(
  //     children: <Widget>[
  //       TableCell(
  //         verticalAlignment: columnOneVerticalAlignment,
  //         child: Padding(
  //           padding: EdgeInsets.symmetric(
  //             horizontal: context.dimens.horizontalMargin,
  //             vertical: context.dimens.verticalMargin,
  //           ),
  //           child: Text(
  //             columnOneText,
  //             style: Theme.of(context).textTheme.bodySmall!.copyWith(
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //           ),
  //         ),
  //       ),
  //       TableCell(
  //         verticalAlignment: columnTwoVerticalAlignment,
  //         child: Padding(
  //           padding: EdgeInsets.symmetric(
  //             horizontal: context.dimens.horizontalMargin,
  //             vertical: context.dimens.verticalMargin,
  //           ),
  //           child: MarkdownBody(
  //             data: columnTwoMarkdown,
  //             fitContent: false,
  //             styleSheet: MarkdownStyleSheet(
  //               p: Theme.of(context).textTheme.bodySmall,
  //               a: Theme.of(context).textTheme.bodySmall!.copyWith(
  //                     color: const Color(0xFF00A1A5), // This is the WebBank requested/required link color for this link
  //                   ),
  //               textAlign: WrapAlignment.end,
  //             ),
  //             onTapLink: (text, href, title) {
  //               AppRouter.of(context).navigateToLink(Uri.parse(href!));
  //             },
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // TableBorder _buildTableBorder(BuildContext context) {
  //   return TableBorder(
  //     top: _buildTableBorderSide(context),
  //     left: _buildTableBorderSide(context),
  //     right: _buildTableBorderSide(context),
  //     bottom: _buildTableBorderSide(context),
  //     horizontalInside: _buildTableBorderSide(context),
  //     verticalInside: _buildTableBorderSide(context),
  //   );
  // }

  // BorderSide _buildTableBorderSide(BuildContext context) {
  //   return BorderSide(
  //     color: context.colors.outline,
  //     width: 1,
  //   );
  // }
}

Widget _TableHeading(
  BuildContext context,
  String columOneText,
  columTwoText,
  columThreeText,
  columFourText,
  columFiveText,
) {
  return Table(
    // border: TableBorder(
    //     // top: _buildTableBorderSide(context),
    //     // left: _buildTableBorderSide(context),
    //     // right: _buildTableBorderSide(context),
    //     ),
    // columnWidths: const <int, TableColumnWidth>{
    //   0: FlexColumnWidth(),
    //   1: FlexColumnWidth(2),
    // },
    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    children: [
      TableRow(
        children: [
          Text(columOneText),
          Text(columTwoText),
          Text(columThreeText),
          Text(columFourText),
          Text(columFiveText),
        ],
      ),
    ],
  );
}

TableRow _TableRow(
  BuildContext context,
  columnOneText,
  columnTwoText,
  columThreeText,
  columnFourText,
  columFiveText,

//   {
//   TableCellVerticalAlignment columnOneVerticalAlignment =
//       TableCellVerticalAlignment.top,
//   TableCellVerticalAlignment columnTwoVerticalAlignment =
//       TableCellVerticalAlignment.top,
// }
) {
  return TableRow(
    children: <Widget>[
      TableCell(
        child: Text(
          columnOneText,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      TableCell(
        child: Text(columnTwoText),
      ),
      TableCell(
        child: Text(columThreeText),
      ),
      TableCell(
        child: Text(columThreeText),
      ),
      TableCell(
        child: Text(columFiveText),
      ),
    ],
  );
}
