import 'package:PopcornMovie/data/datasource/tvmaze_datasource.dart';
import 'package:PopcornMovie/data/models/show.dart';
import 'package:PopcornMovie/data/models/show_detail.dart';
import 'package:PopcornMovie/domain/entities/showList.dart';

class TvMazeRepository {
  static Future<ShowList> showIndex() async {
    return await TvMazeDatasource.showIndex();
  }

  static Future<ShowDetailList> showDetail(int id) async {
    return await TvMazeDatasource.showDetail(id);
  }

  static Future<ShowList> searchShow(String search) async {
    return await TvMazeDatasource.searchShow(search);
  }
}
