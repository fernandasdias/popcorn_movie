import 'package:PopcornMovie/data/models/show_detail.dart';
import 'package:PopcornMovie/presentation/bloc/show_bloc.dart';
import 'package:flutter/material.dart';

import 'package:PopcornMovie/data/models/show.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({
    Key? key,
    required this.showModel,
    required this.context,
    // required this.bloc,
  }) : super(key: key);

  final ShowModel showModel;
  final BuildContext context;
  // final ShowBloc bloc;

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void initState() {
    BlocProvider.of<ShowBloc>(context)
        .add(ShowDetailEvent(widget.showModel.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.showModel.name!),
      ),
      body: BlocBuilder<ShowBloc, ShowState>(builder: (context, state) {
        if (state is DetailLoadedState) {
          print('detail loaded with sucess');
          ShowDetail showDetail = state.show.showDetail;

          return Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.network(showDetail.image),
                    Column(
                      children: [
                        Text(showDetail.name!),
                        Text(showDetail.type!),
                        Text(showDetail.genres.toString()),
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
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
