import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum ImageConstants {
  bag('bag');

  final String value;
  const ImageConstants(this.value);

  String get toPng => 'assets/images/$value.png';
  String get toSvg => 'assets/svg/$value.svg';

  Image get toPngImage => Image.asset(toPng);
  SvgPicture get toSvgImage => SvgPicture.asset(toSvg);
}
