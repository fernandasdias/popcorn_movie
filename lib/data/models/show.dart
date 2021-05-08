import 'package:PopcornMovie/domain/entities/show.dart';
import 'package:flutter/foundation.dart';

class ShowList {
  List<ShowModel> showList = [];
  ShowList.fromJson(List<dynamic> json) {
    int count = 0;
    if (json != null) {
      json.forEach((element) {
        showList.add(ShowModel.fromJson(element));
        // count++;
      });
    }
  }
}

class ShowModel extends Show {
  ShowModel(
      {@required int id,
      @required String name,
      @required dynamic image,
      @required String status,
      @required dynamic summary})
      : super(
            id: id, name: name, image: image, status: status, summary: summary);

  factory ShowModel.fromJson(Map<String, dynamic> json) {
    return ShowModel(
        id: (json['id'] as num).toInt(),
        name: json['name'],
        image: json['image']['medium'],
        status: json['status'],
        summary: json['summary']);
  }
}
