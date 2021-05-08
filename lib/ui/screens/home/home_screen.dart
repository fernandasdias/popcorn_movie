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
      create: (context) => ShowBloc()..add(ShowIndexEvent()),
      child: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              List<ShowModel> shows = state.show.showList;
              // int lenght = shows.length;
              // ShowModel showModel = state.show.showList[0];
              // ShowModel showModel2 = state.show.showList[1];

              return Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      // color: Colors.blueGrey,
                      child: ListView.builder(
                          // padding: EdgeInsets.symmetric(horizontal: 30),
                          itemCount: 6,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext ctx, index) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.network(
                                  shows[index].imageOriginal,
                                  width: MediaQuery.of(context).size.width - 30,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
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
        )
        /*Container(
        color: kPrimaryColorLightest,
        child: SafeArea(
          minimum: EdgeInsets.all(16),
          child: Container(
            child: Column(
              children: [
                Container(
                  // color: Colors.red,
                  child: TextField(
                    readOnly: false,
                    showCursor: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        filled: true,
                        fillColor: kPrimaryColorLightest,
                        prefixIcon: Icon(
                          Icons.search_outlined,
                          color: kPrimaryColorDark,
                          size: 24,
                        )),
                    keyboardType: TextInputType.text,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                BlocBuilder<ShowBloc, ShowState>(builder: (context, state) {
                  if (state is IndexLoadedState) {
                    print('index loaded with sucess');
                    List<ShowModel> shows = state.show.showList;
                    // int lenght = shows.length;
                    // ShowModel showModel = state.show.showList[0];
                    // ShowModel showModel2 = state.show.showList[1];

                    return GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 0.55,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: shows.length,
              itemBuilder: (BuildContext ctx, index) {
                return MovieCard(showModel: shows[index]);
              },
            );
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                })
              ],
            ),
          ),
        ),
      ),*/
        );
  }
}
