import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

Widget carouselSlider( items) {
  return SizedBox(
    height: 200,
    child: CarouselSlider(
      items: items,
      options: CarouselOptions(
          height: 150.0, autoPlay: true, enlargeCenterPage: true),
    ),
  );
}
