import 'package:PopcornMovie/ui/screens/movie_detail/movie_detail_screen.dart';
import 'package:flutter/material.dart';

import 'package:PopcornMovie/data/models/show.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    Key? key,
    required this.showModel,
  }) : super(key: key);

  final ShowModel showModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => MovieDetailScreen(showModel: showModel))),
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
