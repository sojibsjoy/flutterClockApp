import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clock_bloc/state_management/models/enums.dart';
import 'package:meta/meta.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(MenuInitial()) {
    on<MenuEvent>((event, emit) {});
  }
}
