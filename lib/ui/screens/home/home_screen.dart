import 'package:PopcornMovie/domain/entities/show.dart';
import 'package:PopcornMovie/ui/screens/home/search_screen.dart';
import 'package:PopcornMovie/ui/screens/home/widgets/CarouselItem.dart';
import 'package:PopcornMovie/ui/screens/movie_detail/movie_detail_screen.dart';
import 'package:PopcornMovie/ui/screens/movie_detail/widgets/app_bar_detail.dart';
import 'package:PopcornMovie/ui/screens/movie_detail/widgets/app_bar_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:PopcornMovie/presentation/bloc/show_bloc.dart';
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
  static int currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      print('setting state for index $index');
      currentIndex = index;
    });
  }

  final List<Widget> _telas = [
    ShowListScreen(),
    SearchScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
        ],
      ),
      // appBar: AppBar(
      //   title: Text(
      //     'Popcorn Movie',
      //     style: TextStyle(
      //         fontFamily: GoogleFonts.permanentMarker().fontFamily,
      //         color: kSecundaryColorDarkest,
      //         fontWeight: FontWeight.w900,
      //         fontSize: 32,
      //         letterSpacing: 1.8),
      //   ),
      //   backgroundColor: kPrimaryColorLightest,
      //   shadowColor: Colors.transparent,
      // ),
      body: _telas[currentIndex],
    );
  }
}

class ShowListScreen extends StatefulWidget {
  @override
  _ShowListScreenState createState() => _ShowListScreenState();
}

class _ShowListScreenState extends State<ShowListScreen> {
  final ValueNotifier<double> notifier = ValueNotifier(0);
  final CarouselController _controller = CarouselController();
  static const double HEIGHT = 400;
  static const double APPBARHEIGHT = 250;
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
                    child: AppBarWidget(
                      shows,
                      _controller,
                      APPBARHEIGHT,
                    ),
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
