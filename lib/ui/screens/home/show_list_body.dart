import 'package:PopcornMovie/domain/entities/show.dart';
import 'package:PopcornMovie/presentation/bloc/show_bloc.dart';
import 'package:PopcornMovie/ui/screens/home/widgets/movie_card.dart';
import 'package:PopcornMovie/ui/screens/movie_detail/widgets/app_bar_widget.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowListScreen extends StatefulWidget {
  @override
  _ShowListScreenState createState() => _ShowListScreenState();
}

class _ShowListScreenState extends State<ShowListScreen> {
  final ValueNotifier<double> notifier = ValueNotifier(0);
  final CarouselController _controller = CarouselController();
  static const double HEIGHT = 600;
  static const double APPBARHEIGHT = 300;
  final ScrollController _scrollViewController = new ScrollController();
  bool _showAppbar = true;
  bool isScrollingDown = false;
  @override
  void initState() {
    super.initState();

    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showAppbar = false;
          setState(() {});
        }
      }

      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          _showAppbar = true;
          setState(() {});
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollViewController.removeListener(() {});
    _scrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.all(12),
      child: BlocBuilder<ShowBloc, ShowState>(
          buildWhen: (previous, current) =>
              current.runtimeType != DetailLoadedState,
          builder: (context, state) {
            if (state is IndexLoadedState) {
              print('index loaded with sucess');
              List<Show> shows = state.show.showList;

              return Column(
                children: [
                  AnimatedContainer(
                    height: _showAppbar ? APPBARHEIGHT : 0.0,
                    duration: Duration(milliseconds: 200),
                    child:
                        AppBarWidget(shows, _controller, APPBARHEIGHT, context),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  NotificationListener<ScrollNotification>(
                    onNotification: (n) {
                      if (n.metrics.pixels >= HEIGHT) {
                        notifier.value = n.metrics.pixels;
                      }
                      return false;
                    },
                    child: Expanded(
                      flex: 3,
                      child: GridView.builder(
                        controller: _scrollViewController,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 0.55,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 20,
                        ),
                        itemCount: shows.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return MovieCard(
                            show: shows[index],
                            context: context,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }

            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }),
    );
  }
}
