import 'package:PopcornMovie/domain/entities/show.dart';
import 'package:PopcornMovie/presentation/show_detail_presenter.dart';
import 'package:PopcornMovie/ui/screens/movie_detail/movie_detail_screen.dart';

import 'package:flutter/material.dart';

class CarouselItem extends StatelessWidget {
  const CarouselItem({
    Key? key,
    required this.shows,
  }) : super(key: key);

  final Show shows;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MovieDetailProvider(
              show: shows,
              presenter: ShowDetailPresenter(),
            ),
          )),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(3, 3), // changes position of shadow
            ),
          ],
          // border: Border.all(),
          borderRadius: BorderRadius.circular(30),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.network(shows.imageOriginal),
        ),
      ),
    );
  }
}
