import 'package:PopcornMovie/domain/entities/show.dart';
import 'package:PopcornMovie/ui/screens/home/search_screen.dart';
import 'package:PopcornMovie/ui/screens/home/widgets/CarouselItem.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends PreferredSize {
  final List<Show> shows;
  final CarouselController _controller;
  final double height;
  final BuildContext context;

  AppBarWidget(this.shows, this._controller, this.height, this.context)
      : super(
          preferredSize: Size.fromHeight(height),
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () =>
                          showSearch(context: context, delegate: Search()),
                      child: Icon(
                        Icons.search,
                        size: 25,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: height - 55,
                // color: Colors.amber,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment(0.0, 5.0),
                      child: CarouselSlider(
                        items: [
                          CarouselItem(shows: shows[70]),
                          CarouselItem(shows: shows[80]),
                          CarouselItem(shows: shows[90]),
                        ],
                        options: CarouselOptions(
                          viewportFraction: 0.7,
                          enlargeCenterPage: true,
                          aspectRatio: 1.3,
                          autoPlay: true,
                        ),
                        carouselController: _controller,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
}
