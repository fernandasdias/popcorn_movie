import 'dart:math';

import 'package:PopcornMovie/data/models/show_detail.dart';
import 'package:PopcornMovie/domain/entities/show.dart';
import 'package:PopcornMovie/presentation/show_detail_presenter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';

import 'package:PopcornMovie/data/models/show.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/app_bar_detail.dart';
import 'widgets/star_display.dart';

class MovieDetailProvider extends StatefulWidget {
  final Show show;
  final ShowDetailPresenter presenter;
  const MovieDetailProvider(
      {Key? key, required this.show, required this.presenter})
      : super(key: key);

  @override
  _MovieDetailProviderState createState() => _MovieDetailProviderState();
}

class _MovieDetailProviderState extends State<MovieDetailProvider> {
  @override
  void initState() {
    widget.presenter.getShowDetail(widget.show.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ShowDetail>(
        stream: widget.presenter.stepCounterStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print('snapshot has data ${snapshot.data!.name!}');
            return MovieDetailScreen(
              show: snapshot.data!,
              context: context,
            );
          } else
            return Scaffold(
              body: Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
        });
  }
}

class MovieDetailScreen extends StatefulWidget {
  static const String routeName = '/movie-detail';
  const MovieDetailScreen({
    Key? key,
    required this.show,
    required this.context,
    // required this.bloc,
  }) : super(key: key);

  final ShowDetail show;
  final BuildContext context;
  // final ShowBloc bloc;

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  Widget build(BuildContext context) {
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

    /*List<Widget>? cast() {
      List<Widget> castInput = [];
      for (final cast in widget.show.cast['person']) {
        castInput.add(Text('${cast['name']}'));

        castInput.add(
          SizedBox(
            height: 4,
          ),
        );
      }
      return castInput;
    }*/

    String premiered = widget.show.premiered!;
    String year = premiered.substring(0, 4);
    /*List<dynamic> casting = widget.show.cast!;
    List<dynamic>? person;
    casting.map((element) {
      person?.add(element['person']);
      return person;
    });
    print(person);*/

    /*return StreamBuilder<ShowDetail>(
      stream: Provider.of<ShowDetailPresenter>(context).stepCounterStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();

        ShowDetail detail = snapshot.data!;
        print('snapshot ok ${detail.name}');
        return Center();
      },
    );*/
    return Scaffold(
        appBar: AppBarDetail(
          imagePath: widget.show.imageOriginal,
          context: context,
        ),
        body: SingleChildScrollView(
          child: Container(
              // color: Colors.amber,
              padding: EdgeInsets.only(bottom: 20),
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
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
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
                    height: 60,
                  ),
                  Container(
                    // color: Colors.amber,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text('Year',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(year),
                              ],
                            ),
                            Column(
                              children: [
                                Text('Duration',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 8,
                                ),
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
                                Text('Rating',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.red,
                                    ),
                                    Text(
                                        '${(widget.show.average['rating'] == null) ? 0 : widget.show.average['rating']!}/10')
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text('Network',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(widget.show.network['name']),
                              ],
                            ),
                            Column(
                              children: [
                                Text('Schedule',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 8,
                                ),
                                Column(
                                  children: [...days()!],
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  child: Text(
                                    widget.show.schedule['time']!,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  color: Colors.black12,
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text('Status',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 8,
                                ),
                                Text('${widget.show.status!}')
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Sumary',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 8,
                        ),
                        Text(_parseHtmlString(widget.show.summary),
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 16)),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Official Site',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 8,
                        ),
                        InkWell(
                          child: Text(widget.show.officialSite!),
                          onTap: () =>
                              launch('${widget.show.officialSite!}.html'),
                        )
                        /*Column(
                      children: [
                        Text('Cast',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Row(
                          children: [...cast()!],
                        )
                      ],
                    )*/
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }
}
