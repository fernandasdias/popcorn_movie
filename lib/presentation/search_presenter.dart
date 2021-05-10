import 'dart:async';

import 'package:PopcornMovie/domain/entities/show.dart';
import 'package:PopcornMovie/domain/entities/showList.dart';
import 'package:PopcornMovie/domain/usecases/show_usecase.dart';
import 'package:easy_debounce/easy_debounce.dart';

abstract class Presenter {
  void onChanged(String value);
  void onPressed();
  void clear();
  Stream<List<Show>>? get searchValue;
}

class SearchState {
  String value = '';
  List<Show> showList = [];
  bool isSearchValid(String value) {
    return value != '';
  }
}

class SearchPresenter implements Presenter {
  var _controller = StreamController<SearchState>.broadcast();
  var _state = SearchState();
  @override
  Future<void> onChanged(String value) async {
    print('on changed presenter $value');
    if (_state.isSearchValid(value)) {
      _state.value = value;
      EasyDebounce.debounce('debounce-search', Duration(milliseconds: 500),
          () async {
        _state.showList = await ShowUseCase.searchShow(value);
        _update();
      });
    } else
      _state.value = '';
    _state.showList.clear();
  }

  @override
  void onPressed() {
    // TODO: implement onPressed
  }

  String get currentValue => _state.value;
  Stream<List<Show>> get searchValue =>
      _controller.stream.map((state) => state.showList).distinct();

  void search(String searchTerm) {
    print(search);
  }

  void _update() => _controller.add(_state);

  void dispose() {
    _controller.close();
  }

  @override
  void clear() {
    _state.value = '';
    _update();
  }
}
