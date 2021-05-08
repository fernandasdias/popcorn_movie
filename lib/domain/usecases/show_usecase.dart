import 'package:PopcornMovie/data/models/show.dart';
import 'package:PopcornMovie/data/repositories/tvmaze_repository.dart';
import 'package:PopcornMovie/domain/entities/show.dart';

class ShowUseCase {
  static Future<ShowList> showIndex() async {
    ShowList _show = await TvMazeRepository.showIndex();

    print('stop');
    return _show;
  }
}
