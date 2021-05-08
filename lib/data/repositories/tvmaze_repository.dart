import 'package:PopcornMovie/data/datasource/tvmaze_datasource.dart';
import 'package:PopcornMovie/data/models/show.dart';

class TvMazeRepository {
  static Future<ShowList> showIndex() async {
    return await TvMazeDatasource.showIndex();
  }
}
