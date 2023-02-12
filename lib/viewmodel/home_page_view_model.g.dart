// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomePageViewModel on _HomePageViewModel, Store {
  late final _$_indicatorsAtom =
      Atom(name: '_HomePageViewModel._indicators', context: context);

  List<Indicator>? get indicators {
    _$_indicatorsAtom.reportRead();
    return super._indicators;
  }

  @override
  List<Indicator>? get _indicators => indicators;

  @override
  set _indicators(List<Indicator>? value) {
    _$_indicatorsAtom.reportWrite(value, super._indicators, () {
      super._indicators = value;
    });
  }

  late final _$_statusAtom =
      Atom(name: '_HomePageViewModel._status', context: context);

  HomePageStates get status {
    _$_statusAtom.reportRead();
    return super._status;
  }

  @override
  HomePageStates get _status => status;

  @override
  set _status(HomePageStates value) {
    _$_statusAtom.reportWrite(value, super._status, () {
      super._status = value;
    });
  }

  late final _$getDataAsyncAction =
      AsyncAction('_HomePageViewModel.getData', context: context);

  @override
  Future<void> getData() {
    return _$getDataAsyncAction.run(() => super.getData());
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
