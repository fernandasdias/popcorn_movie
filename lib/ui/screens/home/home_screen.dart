import 'package:PopcornMovie/ui/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
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
                        fillColor: kPrimaryColorLight,
                        prefixIcon: Icon(
                          Icons.search_outlined,
                          color: kPrimaryColorDark,
                          size: 24,
                        )),
                    keyboardType: TextInputType.text,
                  ),
                ),
                GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
