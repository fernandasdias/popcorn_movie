import 'package:PopcornMovie/data/models/search_model.dart';
import 'package:PopcornMovie/data/models/show_detail.dart';
import 'package:PopcornMovie/data/repositories/tvmaze_repository.dart';
import 'package:PopcornMovie/domain/entities/show.dart';
import 'package:PopcornMovie/domain/entities/showList.dart';

class ShowUseCase {
  static Future<ShowList> showIndex() async {
    return await TvMazeRepository.showIndex();
  }

  static Future<ShowDetail> showDetail(int id) async {
    return await TvMazeRepository.showDetail(id);
  }

  static Future<List<Show>> searchShow(String search) async {
    SearchModelList _show = await TvMazeRepository.searchShow(search);

    return _show.list;
  }
}
