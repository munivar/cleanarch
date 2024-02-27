import 'package:cleanarch/core/constants/colors.dart';
import 'package:cleanarch/core/constants/const.dart';
import 'package:cleanarch/core/themes/custom_themes/appbar_theme.dart';
import 'package:cleanarch/core/themes/custom_themes/bottom_sheet_theme.dart';
import 'package:cleanarch/core/themes/custom_themes/checkbox_theme.dart';
import 'package:cleanarch/core/themes/custom_themes/chip_theme.dart';
import 'package:cleanarch/core/themes/custom_themes/elevated_button_theme.dart';
import 'package:cleanarch/core/themes/custom_themes/outlined_button_theme.dart';
import 'package:cleanarch/core/themes/custom_themes/text_field_theme.dart';
import 'package:cleanarch/core/themes/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppTheme {
  AppTheme();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: Const.fontFamily,
    brightness: Brightness.light,
    primaryColor: AppColor.primary,
    scaffoldBackgroundColor: AppColor.light,
    textTheme: AppTextTheme.lightTextTheme,
    chipTheme: AppChipTheme.lightAppChipTheme,
    appBarTheme: AppbarTheme.lightAppbarTheme,
    checkboxTheme: AppCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: AppBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: AppOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: AppTextFieldTheme.lightInputDecorationTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: Const.fontFamily,
    brightness: Brightness.dark,
    primaryColor: AppColor.primary,
    scaffoldBackgroundColor: AppColor.dark,
    textTheme: AppTextTheme.darkTextTheme,
    chipTheme: AppChipTheme.darkAppChipTheme,
    appBarTheme: AppbarTheme.darkAppbarTheme,
    checkboxTheme: AppCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: AppBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: AppOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: AppTextFieldTheme.darkInputDecorationTheme,
  );
}

class ThemeState {
  final ThemeMode themeMode;

  ThemeState(this.themeMode);
}

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(ThemeMode.system)) {
    // Load saved theme preference here
  }

  void changeTheme(ThemeMode themeMode) => emit(ThemeState(themeMode));
}
