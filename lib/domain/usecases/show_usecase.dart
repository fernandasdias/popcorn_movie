import 'package:PopcornMovie/data/models/show_detail.dart';
import 'package:PopcornMovie/data/repositories/tvmaze_repository.dart';
import 'package:PopcornMovie/domain/entities/showList.dart';

class ShowUseCase {
  static Future<ShowList> showIndex() async {
    return await TvMazeRepository.showIndex();
  }

  static Future<ShowDetail> showDetail(int id) async {
    return await TvMazeRepository.showDetail(id);
  }

  static Future<ShowList> searchShow(String search) async {
    ShowList _show = await TvMazeRepository.searchShow(search);

    return _show;
  }
}
