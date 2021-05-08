import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'show_event.dart';
part 'show_state.dart';

class ShowBloc extends Bloc<ShowEvent, ShowState> {
  ShowBloc() : super(ShowInitial());

  @override
  Stream<ShowState> mapEventToState(
    ShowEvent event,
  ) async* {
    if (event is ShowIndexEvent) {
      yield* mapShowIndexEvent();
    }
  }

  Stream<ShowState> mapShowIndexEvent() async* {
    //chamar usecase -> repository -> datasource
    yield IndexLoadedState();
  }
}
