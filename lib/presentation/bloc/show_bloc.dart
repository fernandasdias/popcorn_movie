import 'dart:async';

import 'package:PopcornMovie/data/models/show.dart';
import 'package:PopcornMovie/data/models/show_detail.dart';
import 'package:PopcornMovie/domain/entities/show.dart';
import 'package:PopcornMovie/domain/entities/showList.dart';
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
    } else if (event is ShowDetailEvent) {
      print('calling show detail event');
      yield* mapShowDetailEvent(event);
    }
    if (state is SearchShowEvent)
      yield* mapSearchShowEvent(event as SearchShowEvent);
  }

  Stream<ShowState> mapShowIndexEvent() async* {
    yield LoadingState();
    ShowList show = await ShowUseCase.showIndex();
    yield IndexLoadedState(show);
  }

  Stream<ShowState> mapShowDetailEvent(ShowDetailEvent event) async* {
    yield LoadingState();
    ShowDetailList showDetail = await ShowUseCase.showDetail(event.id);
    yield DetailLoadedState(showDetail);
  }

  Stream<ShowState> mapSearchShowEvent(SearchShowEvent event) async* {
    ShowList show = await ShowUseCase.searchShow(event.search);
    yield IndexLoadedState(show);
  }
}
