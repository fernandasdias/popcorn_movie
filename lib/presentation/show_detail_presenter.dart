import 'dart:async';

import 'package:PopcornMovie/data/models/show_detail.dart';
import 'package:PopcornMovie/domain/usecases/show_usecase.dart';
import 'package:PopcornMovie/presentation/bloc/show_bloc.dart';

class ShowDetailPresenter {
  StreamController<ShowDetail> _controller =
      StreamController<ShowDetail>.broadcast();
  void getShowDetail(int id) async {
    ShowDetail showDetail = await ShowUseCase.showDetail(id);
    update(showDetail);
  }

  void update(ShowDetail showDetail) {
    _controller.add(showDetail);
  }

  Stream<ShowDetail> get stepCounterStream =>
      _controller.stream.map((state) => state).distinct();

  void dispose() {
    _controller.close();
  }
}
