import 'package:PopcornMovie/ui/screens/movie_detail/movie_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ui/screens/home/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PopcornMovie',
      theme: ThemeData(
        fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      home: HomeScreenProvider(),
      routes: {
        HomeScreenProvider.routeName: (ctx) => HomeScreenProvider(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
        // MovieDetailScreen.routeName: (ctx) =>
        //     MovieDetailScreen(show: show, context: context)
      },
    );
  }
}
