import 'package:PopcornMovie/data/models/show.dart';
import 'package:PopcornMovie/data/repositories/tvmaze_repository.dart';
import 'package:PopcornMovie/domain/entities/show.dart';

class ShowUseCase {
  static Future<ShowList> showIndex() async {
    return await TvMazeRepository.showIndex();
  }

  static Future<ShowList> searchShow(String search) async {
    ShowList _show = await TvMazeRepository.searchShow(search);

    return _show;
  }
}
