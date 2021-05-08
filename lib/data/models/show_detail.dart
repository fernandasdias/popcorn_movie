import 'package:PopcornMovie/domain/entities/show.dart';

class ShowDetailList {
  late ShowDetail showDetail;
  ShowDetailList.fromJson(dynamic? json) {
    showDetail = ShowDetail.fromJson(json);
  }
}

class ShowDetail extends Show {
  ShowDetail({
    required int id,
    required String? name,
    required dynamic image,
    required dynamic imageOriginal,
    required String? status,
    required dynamic summary,
    required String? type,
    required dynamic genres,
    required int runtime,
    required dynamic average,
    required dynamic schedule,
    required dynamic network,
  }) : super(
          id: id,
          name: name,
          image: image,
          imageOriginal: imageOriginal,
          status: status,
          summary: summary,
          type: type,
          genres: genres,
          runtime: runtime,
          average: average,
          schedule: schedule,
          network: network,
        );

  factory ShowDetail.fromJson(Map<String, dynamic> json) {
    print(json['rating']);
    return ShowDetail(
      id: (json['id'] as num).toInt(),
      name: json['name'],
      image: json['image']['medium'],
      imageOriginal: json['image']['original'],
      status: json['status'],
      summary: json['summary'],
      type: json['type'],
      genres: json['genres'],
      runtime: json['runtime'],
      average: json['rating'],
      schedule: json['schedule'],
      network: json['network'],
    );
  }
}
