import 'package:PopcornMovie/domain/entities/show.dart';
import 'package:PopcornMovie/ui/screens/movie_detail/movie_detail_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:PopcornMovie/data/models/show.dart';
import 'package:PopcornMovie/presentation/bloc/show_bloc.dart';
import 'package:PopcornMovie/ui/theme/colors.dart';
import 'widgets/movie_card.dart';

class HomeScreenProvider extends StatefulWidget {
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
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CarouselController _controller = CarouselController();
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
            if (state is IndexLoadedState) {
              print('index loaded with sucess');
              List<Show> shows = state.show.showList;
              // int lenght = shows.length;
              // ShowModel showModel = state.show.showList[0];
              // ShowModel showModel2 = state.show.showList[1];

              return Column(
                children: [
                  CarouselSlider(
                    items: [
                      CarouselItem(shows: shows[70]),
                      CarouselItem(shows: shows[80]),
                      CarouselItem(shows: shows[90]),
                    ],
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      aspectRatio: 1.4,
                      // onPageChanged: null,
                      autoPlay: false,
                    ),
                    carouselController: _controller,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // Flexible(
                        //   child: TextButton(
                        //     onPressed: () => _controller.previousPage(),
                        //     child: Text('←'),
                        //   ),
                        // ),
                        // Flexible(
                        //   child: TextButton(
                        //     onPressed: () => _controller.nextPage(),
                        //     child: Text('→'),
                        //   ),
                        // ),
                        // ...Iterable<int>.generate(3).map(
                        //   (int pageIndex) => Flexible(
                        //     child: TextButton(
                        //       onPressed: () =>
                        //           _controller.animateToPage(pageIndex),
                        //       child: Text("$pageIndex"),
                        //     ),
                        //   ),
                        // ),
                        // child: Container(
                        //   // color: Colors.blueGrey,
                        //   child: ListView.builder(
                        //       // padding: EdgeInsets.symmetric(horizontal: 30),
                        //       itemCount: 6,
                        //       scrollDirection: Axis.horizontal,
                        //       itemBuilder: (BuildContext ctx, index) {
                        //         return Container(
                        //           padding: EdgeInsets.symmetric(horizontal: 10),
                        //           child: ClipRRect(
                        //             borderRadius: BorderRadius.circular(30),
                        //             child: Image.network(
                        //               shows[index].imageOriginal,
                        //               width: MediaQuery.of(context).size.width - 30,
                        //               fit: BoxFit.fitWidth,
                        //             ),
                        //           ),
                        //         );
                        //       }),
                        // ),
                      ]),
                  SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    flex: 3,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 0.55,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: shows.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return MovieCard(showModel: shows[index]);
                      },
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

class CarouselItem extends StatelessWidget {
  const CarouselItem({
    Key? key,
    required this.shows,
  }) : super(key: key);

  final Show shows;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MovieDetailScreen(showModel: shows),
          )),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(3, 3), // changes position of shadow
            ),
          ],
          // border: Border.all(),
          borderRadius: BorderRadius.circular(30),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.network(shows.imageOriginal),
        ),
      ),
    );
  }
}
