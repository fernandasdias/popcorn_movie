import 'package:PopcornMovie/data/models/show_detail.dart';
import 'package:PopcornMovie/domain/entities/show.dart';
import 'package:PopcornMovie/presentation/show_detail_presenter.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';

import 'package:url_launcher/url_launcher.dart';

import 'widgets/app_bar_detail.dart';

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
      body: Container(
        // color: Colors.amber,
        padding: EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                // color: Colors.blue,
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
            ),
            Expanded(
              flex: 5,
              child: Container(
                // color: Colors.amber,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildYear(year),
                            buildDuration(),
                            buildRating(),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildNetwork(),
                            buildSchedule(days),
                            buildStatus(),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        buildSumary(_parseHtmlString),
                        SizedBox(
                          height: 20,
                        ),
                        buildOfficialSite(),
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column buildYear(String year) {
    return Column(
      children: [
        buildSubtitleText('Year'),
        SizedBox(
          height: 8,
        ),
        Text(year),
      ],
    );
  }

  Column buildDuration() {
    return Column(
      children: [
        buildSubtitleText('Duration'),
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
    );
  }

  Column buildRating() {
    return Column(
      children: [
        buildSubtitleText('Rating'),
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
    );
  }

  Column buildNetwork() {
    return Column(
      children: [
        buildSubtitleText('Network'),
        SizedBox(
          height: 8,
        ),
        Text(widget.show.network['name']),
      ],
    );
  }

  Column buildSchedule(List<Widget>? days()) {
    return Column(
      children: [
        buildSubtitleText('Schedule'),
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
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          color: Colors.black12,
        )
      ],
    );
  }

  Column buildStatus() {
    return Column(
      children: [
        buildSubtitleText('Status'),
        SizedBox(
          height: 8,
        ),
        Text('${widget.show.status!}')
      ],
    );
  }

  Column buildSumary(String _parseHtmlString(String htmlString)) {
    return Column(
      children: [
        buildSubtitleText('Sumary'),
        SizedBox(
          height: 8,
        ),
        Text(_parseHtmlString(widget.show.summary),
            textAlign: TextAlign.justify, style: TextStyle(fontSize: 16)),
      ],
    );
  }

  Column buildOfficialSite() {
    return Column(
      children: [
        buildSubtitleText('Official Site'),
        SizedBox(
          height: 8,
        ),
        InkWell(
          child: Text(widget.show.officialSite!),
          onTap: () => launch('${widget.show.officialSite!}.html'),
        )
      ],
    );
  }

  Text buildSubtitleText(String subtitle) {
    return Text(subtitle,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
  }
}
