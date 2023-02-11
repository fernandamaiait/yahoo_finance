import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:yahoo_finance/viewmodel/home_page_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomePageViewModel viewModel;

  @override
  void initState() {
    viewModel = HomePageViewModel();
    viewModel.getData();
    super.initState();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guide - Yahoo Finance'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.show_chart),
          ),
        ],
      ),
      body: Observer(
        builder: (context) {
          switch (viewModel.status) {
            case HomePageStates.loading:
              return const Center(child: CircularProgressIndicator());
            case HomePageStates.idle:
              return const Center(child: Text('Idle'));
            case HomePageStates.success:
              return _SuccessContent(viewModel);
            case HomePageStates.error:
              return const Center(child: const Text('Error'));
          }
        },
      ),
    );
  }
}

class _SuccessContent extends StatelessWidget {
  const _SuccessContent(this.viewModel);

  final HomePageViewModel viewModel;

  static final currencyFormatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
  static final compactFormatter = NumberFormat.compact(
    locale: 'en_US',
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const _TableHeader(),
            Observer(builder: (context) {
              return Table(
                //    border: _buildTableBorder(context),
                // columnWidths: const <int, TableColumnWidth>{
                //   0: FlexColumnWidth(),
                //   1: FlexColumnWidth(2),
                // },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: <TableRow>[
                  for (int i = 0; i < 29; i++)
                    _buildTableRow(
                      context,
                      (i + 2).toString(),
                      viewModel.timestamps![i].toString(),
                      currencyFormatter.format(viewModel.openValues![i]),
                      _getDMinusOneVariation(viewModel, i),
                      _getDayOneVariation(viewModel, i),
                    ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  String _getDMinusOneVariation(HomePageViewModel viewModel, int i) {
    return i == 0
        ? '---'
        : compactFormatter.format(
            _getVariation(
              viewModel.openValues![i - 1],
              viewModel.openValues![i],
            ),
          );
  }

  String _getDayOneVariation(HomePageViewModel viewModel, int i) {
    return i == 0
        ? '---'
        : '${compactFormatter.format(
            _getVariation(
              viewModel.openValues![0],
              viewModel.openValues![i],
            ),
          )} %';
  }

  double _getVariation(double priorValue, double currentValue) {
    return (currentValue - priorValue) * 100 / priorValue;
  }
}

class _TableHeader extends StatelessWidget {
  const _TableHeader();

  @override
  Widget build(BuildContext context) {
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
      children: const [
        TableRow(
          children: [
            Text('Dia', textAlign: TextAlign.left),
            Text('Data'),
            Text('Valor'),
            Text('D-1'),
            Text('D1'),
          ],
        ),
      ],
    );
  }
}

TableRow _buildTableRow(
  BuildContext context,
  columnOneText,
  columnTwoText,
  columnThreeText,
  columnFourText,
  columnFiveText,

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
          textAlign: TextAlign.center,
        ),
      ),
      TableCell(
        child: Text(
          columnTwoText,
          textAlign: TextAlign.center,
        ),
      ),
      TableCell(
        child: Text(columnThreeText, textAlign: TextAlign.right),
      ),
      TableCell(
        child: Text(columnFourText, textAlign: TextAlign.right),
      ),
      TableCell(
        child: Text(
          columnFiveText,
          textAlign: TextAlign.right,
        ),
      ),
    ],
  );
}
