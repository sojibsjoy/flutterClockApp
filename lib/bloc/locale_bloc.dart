import 'dart:async';

import 'package:clock_bloc/l10n/l10n.dart';
import 'package:flutter/material.dart';

class LocaleBloc {
  var _locale = L10n.all.first;

  final _stateStreamController = StreamController<Locale>();
  StreamSink<Locale> get _localeSink => _stateStreamController.sink;
  Stream<Locale> get localStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<Locale>();
  StreamSink<Locale> get eventSink => _eventStreamController.sink;
  Stream<Locale> get _eventStream => _eventStreamController.stream;

  LocaleBloc() {
    _eventStream.listen((event) {
      for (var newLocale in L10n.all) {
        if (newLocale == event) {
          _locale = newLocale;
        }
      }
      _localeSink.add(_locale);
    });
  }
}
