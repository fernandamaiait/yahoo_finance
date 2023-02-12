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
              return _ErrorContent(
                onRetryPressed: _OnRetryPressed,
              );
          }
        },
      ),
    );
  }

  void _OnRetryPressed() async {
    await viewModel.getData();
  }
}

class _ErrorContent extends StatelessWidget {
  const _ErrorContent({required this.onRetryPressed});

  final VoidCallback onRetryPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.error,
          color: Colors.red,
        ),
        const Text('Não foi possível consultar o ativo'),
        ElevatedButton(
          onPressed: onRetryPressed,
          child: const Text('Tentar novamente'),
        ),
      ],
    ));
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
                border: TableBorder.all(
                  color: Colors.black12,
                  width: 1,
                ),
                columnWidths: _getColumWidths,
                children: <TableRow>[
                  for (var indicator in viewModel.indicators!)
                    _buildTableRow(
                      context,
                      indicator.day.toString(),
                      DateFormat('dd/MM/yyyy').format(indicator.timestamp),
                      currencyFormatter.format(indicator.openValue),
                      _formatVariation(indicator.dMinusOneVariation),
                      _formatVariation(indicator.dOneVariation),
                    ),
                  // for (viewModel.in)
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  String _formatVariation(double? variation) {
    return variation == null
        ? '---'
        : '${compactFormatter.format(variation)} %';
  }
}

class _TableHeader extends StatelessWidget {
  const _TableHeader();

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
      color: Theme.of(context).colorScheme.onPrimary,
      fontWeight: FontWeight.bold,
    );

    return Table(
      border: TableBorder(
        top: _buildTableBorderSide(context),
        left: _buildTableBorderSide(context),
        right: _buildTableBorderSide(context),
        verticalInside: _buildTableBorderSide(context),
      ),
      columnWidths: _getColumWidths,
      children: <TableRow>[
        TableRow(
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          children: [
            _TableCell(
                text: 'Dia', textAlign: TextAlign.center, textStyle: textStyle),
            _TableCell(
                text: 'Data',
                textAlign: TextAlign.center,
                textStyle: textStyle),
            _TableCell(
                text: 'Valor',
                textAlign: TextAlign.center,
                textStyle: textStyle),
            _TableCell(
                text: 'D-1', textAlign: TextAlign.center, textStyle: textStyle),
            _TableCell(
              text: 'D1',
              textAlign: TextAlign.center,
              textStyle: textStyle,
            )
          ],
        )
      ],
    );
  }
}

TableRow _buildTableRow(
  BuildContext context,
  dayText,
  timestampText,
  openValueText,
  dMinusOneVariationText,
  dOneVariationText,
) {
  return TableRow(
    decoration: BoxDecoration(
        color: (int.parse(dayText) % 2 == 1)
            ? Theme.of(context).primaryColorLight
            : null),
    children: <Widget>[
      _TableCell(
        text: dayText,
        textAlign: TextAlign.center,
      ),
      _TableCell(
        text: timestampText,
        textAlign: TextAlign.center,
      ),
      _TableCell(text: openValueText),
      _TableCell(text: dMinusOneVariationText),
      _TableCell(text: dOneVariationText),
    ],
  );
}

class _TableCell extends StatelessWidget {
  const _TableCell({
    required this.text,
    this.textAlign = TextAlign.right,
    this.textStyle,
  });

  final String text;
  final TextAlign textAlign;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          textAlign: textAlign,
          style: textStyle,
        ),
      ),
    );
  }
}

BorderSide _buildTableBorderSide(BuildContext context) {
  return const BorderSide(
    color: Colors.black12,
    width: 1,
  );
}

get _getColumWidths {
  return const <int, TableColumnWidth>{
    0: FlexColumnWidth(1),
    1: FlexColumnWidth(3),
    2: FlexColumnWidth(2),
    3: FlexColumnWidth(2),
    4: FlexColumnWidth(2),
  };
}
