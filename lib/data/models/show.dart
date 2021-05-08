import 'package:PopcornMovie/domain/entities/show.dart';
import 'package:flutter/foundation.dart';

class ShowModel extends Show {
  ShowModel(
      {@required int id,
      @required String name,
      @required String image,
      @required String status,
      @required String summary})
      : super(id, name, image, status, summary);

  factory ShowModel.fromJson(Map<String, dynamic> json) {
    return ShowModel(
        id: (json['id'] as num).toInt(),
        name: json['name'],
        image: json['image'],
        status: json['status'],
        summary: json['summary']);
  }
}
