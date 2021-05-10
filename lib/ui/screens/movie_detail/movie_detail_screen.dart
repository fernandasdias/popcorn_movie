import 'package:PopcornMovie/data/models/show_detail.dart';
import 'package:PopcornMovie/domain/entities/show.dart';
import 'package:PopcornMovie/presentation/show_detail_presenter.dart';
import 'package:flutter/material.dart';
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
  // var detailPresenter = Provider.of<ShowDetailPresenter>(context);

  @override
  Widget build(BuildContext context) {
    // print('Size: ${MediaQuery.of(context).size.height}');
    // int avarage =
    //     (widget.show.average == null) ? 0 : (widget.show.average).toInt();
    // int value = (avarage * 0.5).toInt();

    // return StreamBuilder<ShowDetail>(
    //     stream: Provider.of<ShowDetailPresenter>(context).stepCounterStream,
    //     builder: (context, snapshot) {
    //       if (!snapshot.hasData) return CircularProgressIndicator();

    //       ShowDetail detail = snapshot.data!;
    //       print('snapshot ok ${detail.name}');
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
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      softWrap: true,
                    ),
                    IconTheme(
                        data: IconThemeData(color: Colors.amber, size: 24),
                        child: StarDisplay(
                          value: 0,
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
      ),
    );
  }
}
