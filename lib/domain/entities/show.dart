import 'package:equatable/equatable.dart';

class Show extends Equatable {
  final int id;
  final String name;
  final String status;
  final String image;
  final String summary;

  Show(this.id, this.name, this.status, this.image, this.summary);

  @override
  List<Object> get props => [id, status, image, summary];
}
