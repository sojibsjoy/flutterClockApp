import 'dart:async';

import 'package:clock_bloc/state_management/models/enums.dart';

class TestMenuBloc {
  var _selectedMenu = MenuType.clock;

  final _stateStreamController = StreamController<MenuType>();
  StreamSink<MenuType> get _menuSink => _stateStreamController.sink;
  Stream<MenuType> get menuStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<MenuType>();
  StreamSink<MenuType> get eventSink => _eventStreamController.sink;
  Stream<MenuType> get _eventStream => _eventStreamController.stream;

  TestMenuBloc() {
    _eventStream.listen((event) {
      if (event == MenuType.alarm) {
        _selectedMenu = MenuType.alarm;
      } else if (event == MenuType.clock) {
        _selectedMenu = MenuType.clock;
      } else if (event == MenuType.timer) {
        _selectedMenu = MenuType.timer;
      } else if (event == MenuType.stopwatch) {
        _selectedMenu = MenuType.stopwatch;
      }
      _menuSink.add(_selectedMenu);
    });
  }
}
