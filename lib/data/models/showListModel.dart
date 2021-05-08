import 'package:PopcornMovie/data/models/show.dart';
import 'package:PopcornMovie/domain/entities/showList.dart';

class ShowListModel {
  ShowList _showList = ShowList(showList: []);
  ShowList get showList => _showList;

  ShowList fromJson(List<dynamic> json) {
    try {
      json.forEach((element) {
        _showList.showList.add(ShowModel.fromJson(element));
      });
      return showList;
    } on Exception catch (e) {
      print(e);
      rethrow;
    }
  }
}
