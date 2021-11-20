part of 'menu_bloc.dart';

@immutable
abstract class MenuState {}

class MenuInitial extends MenuState {
  final _stateStreamController = StreamController<MenuType>();

  StreamSink<MenuType> get _menuSink => _stateStreamController.sink;

  Stream<MenuType> get menuStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<MenuType>();

  StreamSink<MenuType> get eventSink => _eventStreamController.sink;

  Stream<MenuType> get _eventStream => _eventStreamController.stream;
}
