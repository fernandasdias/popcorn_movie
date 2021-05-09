import 'package:PopcornMovie/data/models/show_detail.dart';
import 'package:PopcornMovie/domain/entities/show.dart';
import 'package:PopcornMovie/presentation/bloc/show_bloc.dart';
import 'package:flutter/material.dart';

import 'package:PopcornMovie/data/models/show.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/app_bar_detail.dart';
import 'widgets/star_display.dart';

class MovieDetailScreen extends StatefulWidget {
  static const String routeName = '/movie-detail';
  const MovieDetailScreen({
    Key? key,
    required this.show,
    required this.context,
    // required this.bloc,
  }) : super(key: key);

  final Show show;
  final BuildContext context;
  // final ShowBloc bloc;

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  /*@override
  void initState() {
    BlocProvider.of<ShowBloc>(context).add(ShowDetailEvent(widget.show.id!));
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    // print('Size: ${MediaQuery.of(context).size.height}');
    int avarage =
        (widget.show.average == null) ? 0 : (widget.show.average).toInt();
    int value = (avarage * 0.5).toInt();
    dynamic network = widget.show.network;
    // print(network['name'].toString());

    return Scaffold(
        appBar: AppBarDetail(
          imagePath: widget.show.imageOriginal,
          context: context,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  // color: Colors.blue,
                  // alignment: Alignment.topRight,
                  padding: EdgeInsets.only(left: 150),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.show.name!,
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                        softWrap: true,
                      ),
                      IconTheme(
                          data: IconThemeData(color: Colors.amber, size: 24),
                          child: StarDisplay(
                            value: value,
                          )),
                      Text(widget.show.type!),
                      Text((widget.show.network == null)
                          ? ''
                          : widget.show.network['name']!),
                      Text(widget.show.genres.toString())
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  // color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Directed by'),
                        Text('The Cast',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text('Storyline',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(widget.show.summary,
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 16))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
        /*BlocBuilder<ShowBloc, ShowState>(builder: (context, state) {
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
      }),*/
        );
  }
}
