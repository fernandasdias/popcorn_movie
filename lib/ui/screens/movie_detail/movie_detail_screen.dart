import 'package:flutter/material.dart';

import 'package:PopcornMovie/data/models/show.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({
    Key? key,
    required this.showModel,
  }) : super(key: key);

  final ShowModel showModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(showModel.name!),
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.network(showModel.image),
                Column(
                  children: [
                    Text(showModel.name!),
                    Text(showModel.type!),
                    Text(showModel.genres.toString()),
                    // Text('${showModel.average}'),
                    // Text(
                    //   showModel.network.toString(),
                    //   softWrap: true,
                    // ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
