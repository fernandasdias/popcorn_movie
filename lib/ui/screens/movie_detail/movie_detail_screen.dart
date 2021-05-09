import 'dart:math';

import 'package:PopcornMovie/data/models/show_detail.dart';
import 'package:PopcornMovie/domain/entities/show.dart';
import 'package:PopcornMovie/presentation/bloc/show_bloc.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import '';

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
    String _parseHtmlString(String htmlString) {
      final document = parse(htmlString);
      final String parsedString =
          parse(document.body!.text).documentElement!.text;

      return parsedString;
    }

    List<Widget>? genres() {
      List<Widget> genresInput = [];
      for (final genre in widget.show.genres) {
        genresInput.add(Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.red[100],
          ),
          child: Text('  $genre  '),
        ));

        genresInput.add(
          SizedBox(
            width: 4,
          ),
        );
      }
      return genresInput;
    }

    List<Widget>? days() {
      List<Widget> daysInput = [];
      for (final day in widget.show.schedule['days']) {
        daysInput.add(Text('$day'));

        daysInput.add(
          SizedBox(
            height: 4,
          ),
        );
      }
      return daysInput;
    }

    return Scaffold(
        appBar: AppBarDetail(
          imagePath: widget.show.imageOriginal,
          context: context,
        ),
        body: SingleChildScrollView(
            child: Container(
                /*decoration: BoxDecoration(
              // Box decoration takes a gradient
              gradient: LinearGradient(colors: [
                // Colors are easy thanks to Flutter's Colors class.
                Color(0xFF100328).withOpacity(0.8),
                Color(0xFF010332).withOpacity(0.8),
                Color(0xFF29011C).withOpacity(0.9),
              ], stops: [
                0.0,
                0.595,
                0.845,
              ], transform: GradientRotation(2.13959913 * pi)),
            ),*/
                child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              // color: Colors.blue,
              // alignment: Alignment.topRight,
              padding: EdgeInsets.only(left: 150),
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.show.name!,
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      softWrap: true,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [...genres()!],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 56,
            ),
            SingleChildScrollView(
              child: Container(
                color: Colors.amber,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text('Year'),
                            Text('Year'),
                          ],
                        ),
                        Column(
                          children: [
                            Text('Duration'),
                            Row(
                              children: [
                                Icon(Icons.access_time),
                                Text('${widget.show.runtime!} min')
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text('Rating'),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.red,
                                ),
                                Text('${widget.show.average!}/10')
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text('Network'),
                            Text(widget.show.network['name']),
                          ],
                        ),
                        Column(
                          children: [
                            Text('Schedule'),
                            Row(
                              children: [
                                Column(
                                  children: [...days()!],
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(widget.show.schedule['time']!),
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text('Status'),
                            Text('${widget.show.status!}')
                          ],
                        ),
                      ],
                    ),
                    Container(
                      // color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Sumary',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Text(_parseHtmlString(widget.show.summary),
                                textAlign: TextAlign.justify,
                                style: TextStyle(fontSize: 16)),
                            Text('Cast',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ))
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
            ));
  }
}
