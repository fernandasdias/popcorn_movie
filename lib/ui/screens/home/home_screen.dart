import 'package:PopcornMovie/domain/entities/show.dart';
import 'package:PopcornMovie/ui/screens/home/widgets/CarouselItem.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:PopcornMovie/presentation/bloc/show_bloc.dart';
import 'package:PopcornMovie/ui/theme/colors.dart';
import 'widgets/movie_card.dart';

class HomeScreenProvider extends StatefulWidget {
  static const String routeName = '/home-provider';
  @override
  _HomeScreenProviderState createState() => _HomeScreenProviderState();
}

class _HomeScreenProviderState extends State<HomeScreenProvider> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ShowBloc()..add(ShowIndexEvent()), //add(SearchShowEvent('girls')),
      // ShowBloc()..add(ShowDetailEvent(1)), //add(SearchShowEvent('girls')),
      child: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<double> notifier = ValueNotifier(0);
  static const double HEIGHT = 700;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Popcorn Movie',
            style: TextStyle(
                fontFamily: GoogleFonts.permanentMarker().fontFamily,
                color: kSecundaryColorDarkest,
                fontWeight: FontWeight.w900,
                fontSize: 32,
                letterSpacing: 1.8),
          ),
          backgroundColor: kPrimaryColorLightest,
          shadowColor: Colors.transparent,
        ),
        body: SafeArea(
          minimum: EdgeInsets.all(12),
          child: BlocBuilder<ShowBloc, ShowState>(builder: (context, state) {
            /*if (state is DetailLoadedState) {
              return Center(
                child: MovieCard(
                  context: context,
                  show: state.show.showDetail,
                ),
              );
            }*/
            if (state is IndexLoadedState) {
              print('index loaded with sucess');
              List<Show> shows = state.show.showList;

              return Column(
                children: [
                  HideableWidget(
                    height: HEIGHT,
                    shows: shows,
                    notifier: notifier,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    flex: 3,
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (n) {
                        if (n.metrics.pixels <= HEIGHT) {
                          notifier.value = n.metrics.pixels;
                        }
                        return false;
                      },
                      child: GridView.builder(
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

            return Center(
              child: CircularProgressIndicator(),
            );
          }),
        ));
  }
}

class HideableWidget extends StatelessWidget {
  final List<Show> shows;
  final double height;
  final ValueNotifier<double> notifier;

  HideableWidget(
      {required this.height, required this.notifier, required this.shows});

  @override
  Widget build(BuildContext context) {
    final CarouselController _controller = CarouselController();
    return ValueListenableBuilder<double>(
      valueListenable: notifier,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, value - height),
          child: Container(
            height: 200,
            // color: Colors.red,
            child: CarouselSlider(
              items: [
                CarouselItem(shows: shows[70]),
                CarouselItem(shows: shows[80]),
                CarouselItem(shows: shows[90]),
              ],
              options: CarouselOptions(
                enlargeCenterPage: true,
                aspectRatio: 1.4,
                autoPlay: false,
              ),
              carouselController: _controller,
            ),
          ),
        );
      },
    );
  }
}
