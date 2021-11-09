import 'package:flutter/material.dart';

class SDP {
  static int? dimen;
  static double? width;
  static double? height;
  static BuildContext? context;

  static void init(BuildContext c) {
    context = c;
    width = MediaQuery.of(context!).size.width;
    height = MediaQuery.of(context!).size.height;
  }

  static double sdp(double dp) {
    bool desktop = width! >= 1024;
    bool tablet = width! >= 700;
    bool mobileLarge = width! >= 500;
    var size = desktop
        ? (dp / 900) * height!
        : tablet
            ? (dp / 700) * height!
            : mobileLarge
                ? (dp / 500) * height!
                : (dp / 300) * width!;
    return size;
  }
}
