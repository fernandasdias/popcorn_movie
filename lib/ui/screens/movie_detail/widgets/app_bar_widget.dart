import 'package:PopcornMovie/domain/entities/show.dart';
import 'package:PopcornMovie/ui/screens/home/widgets/CarouselItem.dart';
import 'package:PopcornMovie/ui/theme/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarWidget extends PreferredSize {
  final List<Show> shows;
  final CarouselController _controller;
  final double height;

  AppBarWidget(this.shows, this._controller, this.height)
      : super(
          preferredSize: Size.fromHeight(height),
          child: Container(
            height: height,
            // color: Colors.amber,
            child: Stack(
              children: [
                // Container(
                //   height: 300,
                //   width: double.maxFinite,
                //   padding: const EdgeInsets.symmetric(horizontal: 20),
                //   // decoration: BoxDecoration(gradient: AppGradients.linear),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [],
                //   ),
                // ),
                // Text(
                //   'Popcorn Movie',
                //   style: TextStyle(
                //       fontFamily: GoogleFonts.permanentMarker().fontFamily,
                //       color: kSecundaryColorDarkest,
                //       fontWeight: FontWeight.w900,
                //       fontSize: 32,
                //       letterSpacing: 1.8),
                // ),
                // backgroundColor: kPrimaryColorLightest,
                // shadowColor: Colors.transparent,),
                Align(
                  alignment: Alignment(0.0, 1.0),
                  child: CarouselSlider(
                    items: [
                      CarouselItem(shows: shows[70]),
                      CarouselItem(shows: shows[80]),
                      CarouselItem(shows: shows[90]),
                    ],
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      // aspectRatio: 1.4,
                      autoPlay: false,
                    ),
                    carouselController: _controller,
                  ),
                ),
              ],
            ),
          ),
        );
}
