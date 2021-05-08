import 'package:PopcornMovie/domain/entities/show.dart';
import 'package:flutter/material.dart';

import 'package:PopcornMovie/data/models/show.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({
    Key? key,
    required this.showModel,
  }) : super(key: key);

  final Show showModel;

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void initState() {
    // BlocProvider.of(context).add(ShowMainInformation(widget.showModel.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.showModel.name!),
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.network(widget.showModel.image),
                Column(
                  children: [
                    Text(widget.showModel.name!),
                    Text(widget.showModel.type!),
                    Text(widget.showModel.genres.toString()),
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
