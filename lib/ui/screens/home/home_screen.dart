import 'package:PopcornMovie/presentation/bloc/show_bloc.dart';
import 'package:PopcornMovie/ui/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
      body: Container(
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
                BlocBuilder<ShowBloc, ShowState>(builder: (context, state) {
                  if (state is IndexLoadedState) {
                    print('index loaded with sucess');
                  }
                  return Center(
                    child: Text('Helena'),
                  );
                  /*GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ));*/
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
