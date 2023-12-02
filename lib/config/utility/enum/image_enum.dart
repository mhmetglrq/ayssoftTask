import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum ImageConstants {
  bag('bag'),
  home('home'),
  arrowDown('arrow_down'),
  arrowUp('arrow_up'),
  delete('delete'),
  map('map'),
  visa('visa'),
  emptyBag("empty_bag"),
  empty('empty'),
  heart('heart'),
  ;

  final String value;
  const ImageConstants(this.value);

  String get toPng => 'assets/images/$value.png';
  String get toSvg => 'assets/svg/$value.svg';
  String get toJson => 'assets/json/$value.json';

  Image get toPngImage => Image.asset(toPng);
  SvgPicture get toSvgImage => SvgPicture.asset(toSvg);
}
