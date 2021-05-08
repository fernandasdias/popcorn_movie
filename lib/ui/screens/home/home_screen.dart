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
                      autoPlay: false,
                    ),
                    carouselController: _controller,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[]),
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
