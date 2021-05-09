import 'package:PopcornMovie/domain/entities/show.dart';
import 'package:PopcornMovie/presentation/bloc/show_bloc.dart';
import 'package:PopcornMovie/presentation/show_detail_presenter.dart';
import 'package:PopcornMovie/ui/screens/movie_detail/movie_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    Key? key,
    required this.show,
    required this.context,
  }) : super(key: key);

  final Show show;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // BlocProvider.of<ShowBloc>(context).add(ShowDetailEvent(show.id!));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MovieDetailProvider(
              show: show,
              presenter: ShowDetailPresenter(),
            ),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            show.name!,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                show.image,
                semanticLabel: show.name,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Text(
          //   show.status!,
          //   style: TextStyle(fontSize: 12),
          // )
        ],
      ),
    );
  }
}
