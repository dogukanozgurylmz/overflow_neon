import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? miniTablet;
  final Widget? tablet;
  final Widget? miniDesktop;
  final Widget desktop;
  final Widget? extraLargeDesktop;

  const Responsive({
    Key? key,
    required this.mobile,
    this.miniTablet,
    this.tablet,
    this.miniDesktop,
    required this.desktop,
    this.extraLargeDesktop,
  }) : super(key: key);

  /// xs 0-500
  static bool isExtraSmall(BuildContext context) =>
      MediaQuery.of(context).size.width < 500;

  /// s 500-600
  static bool isSmall(BuildContext context) =>
      MediaQuery.of(context).size.width >= 500 &&
      MediaQuery.of(context).size.width < 600;

  /// m 600-800
  static bool isMedium(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 800;

  /// l 800-1000
  static bool isLarge(BuildContext context) =>
      MediaQuery.of(context).size.width >= 800 &&
      MediaQuery.of(context).size.width < 1000;

  /// xl 1000-1250
  static bool isExtraLarge(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1000 &&
      MediaQuery.of(context).size.width < 1250;

  /// xxl more than 1250
  static bool isXXLarge(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1250;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    if (isXXLarge(context) && extraLargeDesktop != null) {
      return extraLargeDesktop!;
    } else if (isExtraLarge(context)) {
      return desktop;
    } else if (isLarge(context) && miniDesktop != null) {
      return miniDesktop!;
    } else if (isLarge(context)) {
      return desktop;
    } else if (isMedium(context) && tablet != null) {
      return tablet!;
    } else if (isMedium(context)) {
      return miniDesktop ?? desktop;
    } else if (isSmall(context) && miniTablet != null) {
      return miniTablet!;
    } else if (isSmall(context) && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}

//1200 den büyük ->xxl
//1200-1000 desktop ->xl
//1000-800 mini desktop ->l
//800-600 tablet ->m
//600-500 mini tablet ->s
//500-0 mobile ->xs