import 'package:PopcornMovie/presentation/bloc/show_bloc.dart';
import 'package:PopcornMovie/ui/screens/movie_detail/movie_detail_screen.dart';
import 'package:flutter/material.dart';

import 'package:PopcornMovie/data/models/show.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    Key? key,
    required this.showModel,
    required this.context,
  }) : super(key: key);

  final ShowModel showModel;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => MovieDetailScreen(
                      showModel: showModel,
                      context: context,
                      // bloc: BlocProvider.of<ShowBloc>(context),
                    )));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            showModel.name!,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                showModel.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            showModel.status!,
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
