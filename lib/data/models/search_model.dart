import 'package:PopcornMovie/domain/entities/show.dart';

class SearchModelList {
  List<Show> list = [];
  SearchModelList.fromJson(dynamic json) {
    json.forEach((element) {
      list.add(SearchModel().fromJson(element['show']));
    });
  }
}

class SearchModel {
  late int id;
  late String name;
  late dynamic image;
  Show fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image']['medium'];
    name = json['name'];
    return new Show(id: id, name: name, image: image);
  }
}
