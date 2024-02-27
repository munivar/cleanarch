import 'dart:io';
import 'package:cleanarch/core/device/enums.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Utils {
  Utils();

  // getting device type
  static DeviceType get deviceType {
    final mediaQueryData = MediaQueryData.fromView(
        WidgetsBinding.instance.platformDispatcher.implicitView!);
    final double width = mediaQueryData.size.width;
    if (width >= 2560) {
      return DeviceType.is4K;
    } else if (width >= 1440) {
      return DeviceType.isLapBig;
    } else if (width >= 1024) {
      return DeviceType.isLaptop;
    } else if (width >= 768) {
      return DeviceType.isTablet;
    } else if (width >= 425) {
      return DeviceType.isBig;
    } else if (width >= 375) {
      return DeviceType.isMedium;
    } else if (width >= 360) {
      return DeviceType.isSmall;
    } else {
      return DeviceType.isMini;
    }
  }

  // getting device orientation
  static DevicesOrientation get deviceOrientation {
    final orientation =
        // ignore: deprecated_member_use
        MediaQueryData.fromView(WidgetsBinding.instance.window).orientation;
    if (orientation == Orientation.portrait) {
      return DevicesOrientation.isPortrait;
    } else {
      return DevicesOrientation.isLandscape;
    }
  }

  static bool get isSmall => deviceType == DeviceType.isSmall;
  static bool get isMedium => deviceType == DeviceType.isMedium;
  static bool get isBig => deviceType == DeviceType.isBig;
  static bool get isTablet => deviceType == DeviceType.isTablet;
  static bool get isLaptop => deviceType == DeviceType.isLaptop;
  static bool get isLapBig => deviceType == DeviceType.isLapBig;
  static bool get is4K => deviceType == DeviceType.is4K;
  static bool get isWeb => kIsWeb;
  static bool get isPortrait =>
      deviceOrientation == DevicesOrientation.isPortrait;
  static bool get isLandscape =>
      deviceOrientation == DevicesOrientation.isLandscape;

  // responsive sizedbox
  static SizedBox sizedBox(double? height, double? width) {
    return SizedBox(height: height?.h, width: width?.w);
  }

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static Future<void> setStatusBarColor(Color color) async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: color),
    );
  }

  static void setFullScreen(bool enable) {
    SystemChrome.setEnabledSystemUIMode(
        enable ? SystemUiMode.immersiveSticky : SystemUiMode.edgeToEdge);
  }

  static double pixelRatio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  static double statusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static double bottomNavigationBarHeight() {
    return kBottomNavigationBarHeight;
  }

  static double appBarHeight() {
    return kToolbarHeight;
  }

  static double keyboardHeight(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;
    return viewInsets.bottom;
  }

  static Future<bool> isKeyboardVisible(BuildContext context) async {
    final viewInsets = MediaQuery.of(context).viewInsets;
    return viewInsets.bottom > 0;
  }

  static Future<bool> isPhysicalDevice() async {
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  static void vibrate(Duration duration) {
    HapticFeedback.vibrate();
    Future.delayed(duration, () => HapticFeedback.vibrate());
  }

  static Future<void> setPreferredOrientations(
      List<DeviceOrientation> orientations) async {
    await SystemChrome.setPreferredOrientations(orientations);
  }

  static void hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  static void showStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  static void launchUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw "Could not launch $url";
    }
  }
}

// responsive height, width and font
extension ResponsiveSizeExtension on num {
  double get h {
    double screenHeight = MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.implicitView!)
        .size
        .height;
    return screenHeight * (this / 100);
  }

  double get w {
    double screenWidth = MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.implicitView!)
        .size
        .width;
    return screenWidth * (this / 100);
  }

  double get sp {
    double textScaleFactor = MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.implicitView!)
        // ignore: deprecated_member_use
        .textScaleFactor;
    return textScaleFactor * this;
  }
}
