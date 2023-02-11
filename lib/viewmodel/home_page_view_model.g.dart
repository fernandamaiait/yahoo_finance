// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomePageViewModel on _HomePageViewModel, Store {
  late final _$_openValuesAtom =
      Atom(name: '_HomePageViewModel._openValues', context: context);

  List<dynamic>? get openValues {
    _$_openValuesAtom.reportRead();
    return super._openValues;
  }

  @override
  List<dynamic>? get _openValues => openValues;

  @override
  set _openValues(List<dynamic>? value) {
    _$_openValuesAtom.reportWrite(value, super._openValues, () {
      super._openValues = value;
    });
  }

  late final _$_timestampsAtom =
      Atom(name: '_HomePageViewModel._timestamps', context: context);

  List<dynamic>? get timestamps {
    _$_timestampsAtom.reportRead();
    return super._timestamps;
  }

  @override
  List<dynamic>? get _timestamps => timestamps;

  @override
  set _timestamps(List<dynamic>? value) {
    _$_timestampsAtom.reportWrite(value, super._timestamps, () {
      super._timestamps = value;
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
