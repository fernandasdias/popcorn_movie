import 'dart:async';

import 'package:PopcornMovie/data/models/show.dart';
import 'package:PopcornMovie/domain/entities/show.dart';
import 'package:PopcornMovie/domain/usecases/show_usecase.dart';
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
      print('calling show index event');

      yield* mapShowIndexEvent();
    }
  }

  Stream<ShowState> mapShowIndexEvent() async* {
    ShowList show = await ShowUseCase.showIndex();
    yield IndexLoadedState(show);
  }
}
