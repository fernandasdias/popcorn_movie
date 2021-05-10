import 'package:PopcornMovie/domain/entities/show.dart';
import 'package:PopcornMovie/ui/screens/home/search_screen.dart';
import 'package:PopcornMovie/ui/screens/home/show_list_body.dart';
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
