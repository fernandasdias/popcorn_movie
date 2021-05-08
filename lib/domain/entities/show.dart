import 'package:equatable/equatable.dart';

class Show extends Equatable {
  final int? id;
  final String? name;
  final String? status;
  final dynamic image;
  final dynamic imageOriginal;
  final dynamic summary;
  final String? type;
  final dynamic genres;
  final int? runtime;
  final dynamic average;
  final dynamic schedule;
  final dynamic network;

  Show({
    this.imageOriginal,
    this.id,
    this.name,
    this.status,
    this.image,
    this.summary,
    this.type,
    this.genres,
    this.runtime,
    this.average,
    this.schedule,
    this.network,
  });

  @override
  List<Object?> get props => [
        id,
        status,
        image,
        summary,
        imageOriginal,
        type,
        genres,
        runtime,
        average,
        schedule,
        network,
      ];
}
