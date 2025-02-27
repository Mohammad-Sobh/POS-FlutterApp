// ignore_for_file: overridden_fields, annotate_overrides
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_app/core/localizations.dart';

String _language = 'en';

abstract class AppTheme {
  static AppTheme of(BuildContext context) {
    try{
      _language = Localization.of(context).languageCode;
    }
    finally{}

    return Theme.of(context).brightness == Brightness.dark
        ? DarkModeTheme()
        : LightModeTheme();
  }

  late Color primary;
  late Color secondary;
  late Color tertiary;
  late Color alternate;
  late Color primaryText;
  late Color secondaryText;
  late Color primaryBackground;
  late Color secondaryBackground;
  late Color accent1;
  late Color accent2;
  late Color accent3;
  late Color accent4;
  late Color success;
  late Color warning;
  late Color error;
  late Color info;

  String get displayLargeFamily => typography.displayLargeFamily;
  TextStyle get displayLarge => typography.displayLarge;
  String get displayMediumFamily => typography.displayMediumFamily;
  TextStyle get displayMedium => typography.displayMedium;
  String get displaySmallFamily => typography.displaySmallFamily;
  TextStyle get displaySmall => typography.displaySmall;
  String get headlineLargeFamily => typography.headlineLargeFamily;
  TextStyle get headlineLarge => typography.headlineLarge;
  String get headlineMediumFamily => typography.headlineMediumFamily;
  TextStyle get headlineMedium => typography.headlineMedium;
  String get headlineSmallFamily => typography.headlineSmallFamily;
  TextStyle get headlineSmall => typography.headlineSmall;
  String get titleLargeFamily => typography.titleLargeFamily;
  TextStyle get titleLarge => typography.titleLarge;
  String get titleMediumFamily => typography.titleMediumFamily;
  TextStyle get titleMedium => typography.titleMedium;
  String get titleSmallFamily => typography.titleSmallFamily;
  TextStyle get titleSmall => typography.titleSmall;
  String get labelLargeFamily => typography.labelLargeFamily;
  TextStyle get labelLarge => typography.labelLarge;
  String get labelMediumFamily => typography.labelMediumFamily;
  TextStyle get labelMedium => typography.labelMedium;
  String get labelSmallFamily => typography.labelSmallFamily;
  TextStyle get labelSmall => typography.labelSmall;
  String get bodyLargeFamily => typography.bodyLargeFamily;
  TextStyle get bodyLarge => typography.bodyLarge;
  String get bodyMediumFamily => typography.bodyMediumFamily;
  TextStyle get bodyMedium => typography.bodyMedium;
  String get bodySmallFamily => typography.bodySmallFamily;
  TextStyle get bodySmall => typography.bodySmall;

  Typography get typography => ThemeTypography(this);
}

class LightModeTheme extends AppTheme {

  late Color primary = const Color(0xFF4B986C);
  late Color secondary = const Color(0xFF928163);
  late Color tertiary = const Color(0xFF6D604A);
  late Color alternate = const Color(0xFFC8D7E4);
  late Color primaryText = const Color(0xFF0B191E);
  late Color secondaryText = const Color(0xFF384E58);
  late Color primaryBackground = const Color(0xFFF1F4F8);
  late Color secondaryBackground = const Color(0xFFFFFFFF);
  late Color accent1 = const Color(0x4D4B986C);
  late Color accent2 = const Color(0x4D928163);
  late Color accent3 = const Color(0x4C6D604A);
  late Color accent4 = const Color.fromARGB(151, 234, 236, 234);
  late Color success = const Color(0xFF336A4A);
  late Color warning = const Color(0xFFF3C344);
  late Color error = const Color(0xFFC4454D);
  late Color info = const Color(0xFFFFFFFF);
}

abstract class Typography {
  String get displayLargeFamily;
  TextStyle get displayLarge;
  String get displayMediumFamily;
  TextStyle get displayMedium;
  String get displaySmallFamily;
  TextStyle get displaySmall;
  String get headlineLargeFamily;
  TextStyle get headlineLarge;
  String get headlineMediumFamily;
  TextStyle get headlineMedium;
  String get headlineSmallFamily;
  TextStyle get headlineSmall;
  String get titleLargeFamily;
  TextStyle get titleLarge;
  String get titleMediumFamily;
  TextStyle get titleMedium;
  String get titleSmallFamily;
  TextStyle get titleSmall;
  String get labelLargeFamily;
  TextStyle get labelLarge;
  String get labelMediumFamily;
  TextStyle get labelMedium;
  String get labelSmallFamily;
  TextStyle get labelSmall;
  String get bodyLargeFamily;
  TextStyle get bodyLarge;
  String get bodyMediumFamily;
  TextStyle get bodyMedium;
  String get bodySmallFamily;
  TextStyle get bodySmall;
}

//TODO
//Should import the fonts locale
class ThemeTypography extends Typography {
  ThemeTypography(this.theme);

  final AppTheme theme;

  String get displayLargeFamily => _language == 'ar' ? 'Cairo' : 'DM Sans';
  TextStyle get displayLarge => _language == 'ar' ?
    GoogleFonts.getFont(
        'Cairo',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 52.0,
      ) : GoogleFonts.getFont(
        'DM Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 52.0,
        letterSpacing: -1.5
      );
      ////////////////////////
  String get displayMediumFamily => _language == 'ar' ? 'Cairo' : 'DM Sans';
  TextStyle get displayMedium => _language == 'ar' ?
    GoogleFonts.getFont(
        'Cairo',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 44.0,
      ) : GoogleFonts.getFont(
        'DM Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 44.0,
        letterSpacing: -1.5
      );
      /////////////////////////
  String get displaySmallFamily => _language == 'ar' ? 'Cairo' : 'DM Sans';
  TextStyle get displaySmall => _language == 'ar' ?
    GoogleFonts.getFont(
        'Cairo',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 36.0,
      ) : GoogleFonts.getFont(
        'DM Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 36.0,
        letterSpacing: -1.5
      );
      //////////////////////////
  String get headlineLargeFamily => _language == 'ar' ? 'Cairo' : 'DM Sans';
  TextStyle get headlineLarge => _language == 'ar' ?
    GoogleFonts.getFont(
        'Cairo',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 36.0,
      ) : GoogleFonts.getFont(
        'DM Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 36.0,
      );
      ///////////////////////////
  String get headlineMediumFamily => _language == 'ar' ? 'Cairo' : 'DM Sans';
  TextStyle get headlineMedium => _language == 'ar' ?
    GoogleFonts.getFont(
        'Cairo',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 30.0,
      ) : GoogleFonts.getFont(
        'DM Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 30.0,
      );
      ///////////////////////////
  String get headlineSmallFamily => _language == 'ar' ? 'Cairo' : 'DM Sans';
  TextStyle get headlineSmall => _language == 'ar' ?
    GoogleFonts.getFont(
        'Cairo',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 24.0,
      ) : GoogleFonts.getFont(
        'DM Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 24.0,
      );
      ///////////////////////////////
  String get titleLargeFamily => _language == 'ar' ? 'Cairo' : 'DM Sans';
  TextStyle get titleLarge => _language == 'ar' ?
    GoogleFonts.getFont(
        'Cairo',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 22.0,
      ) : GoogleFonts.getFont(
        'DM Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 22.0,
      );
      /////////////////////////////
  String get titleMediumFamily => _language == 'ar' ? 'Cairo' : 'DM Sans';
  TextStyle get titleMedium => _language == 'ar' ?
    GoogleFonts.getFont(
        'Cairo',
        color: theme.info,
        fontWeight: FontWeight.w600,
        fontSize: 18.0,
      ) : GoogleFonts.getFont(
        'DM Sans',
        color: theme.info,
        fontWeight: FontWeight.w600,
        fontSize: 18.0,
      );
      /////////////////////////////
  String get titleSmallFamily => _language == 'ar' ? 'Cairo' : 'DM Sans';
  TextStyle get titleSmall => _language == 'ar' ?
    GoogleFonts.getFont(
        'Cairo',
        color: theme.info,
        fontWeight: FontWeight.w600,
        fontSize: 14.0,
      ) : GoogleFonts.getFont(
        'DM Sans',
        color: theme.info,
        fontWeight: FontWeight.w600,
        fontSize: 14.0,
      );
      ////////////////////////////
  String get labelLargeFamily => _language == 'ar' ? 'Cairo' : 'DM Sans';
  TextStyle get labelLarge => _language == 'ar' ?
    GoogleFonts.getFont(
        'Cairo',
        color: theme.secondaryText,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      ) : GoogleFonts.getFont(
        'DM Sans',
        color: theme.secondaryText,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      );
      ////////////////////////////
  String get labelMediumFamily => _language == 'ar' ? 'Cairo' : 'DM Sans';
  TextStyle get labelMedium => _language == 'ar' ?
    GoogleFonts.getFont(
        'Cairo',
        color: theme.secondaryText,
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
      ) : GoogleFonts.getFont(
        'DM Sans',
        color: theme.secondaryText,
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
      );
      ////////////////////////////
  String get labelSmallFamily => _language == 'ar' ? 'Cairo' : 'DM Sans';
  TextStyle get labelSmall => _language == 'ar' ?
    GoogleFonts.getFont(
        'Cairo',
        color: theme.secondaryText,
        fontWeight: FontWeight.w500,
        fontSize: 12.0,
      ) : GoogleFonts.getFont(
        'DM Sans',
        color: theme.secondaryText,
        fontWeight: FontWeight.w500,
        fontSize: 12.0,
      );
      ////////////////////////////
  String get bodyLargeFamily => _language == 'ar' ? 'Cairo' : 'DM Sans';
  TextStyle get bodyLarge => _language == 'ar' ?
    GoogleFonts.getFont(
        'Cairo',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      ) : GoogleFonts.getFont(
        'DM Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      );
      /////////////////////////////
  String get bodyMediumFamily => _language == 'ar' ? 'Cairo' : 'DM Sans';
  TextStyle get bodyMedium => _language == 'ar' ?
    GoogleFonts.getFont(
        'Cairo',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
      ) : GoogleFonts.getFont(
        'DM Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
      );
      //////////////////////////////
  String get bodySmallFamily => _language == 'ar' ? 'Cairo' : 'DM Sans';
  TextStyle get bodySmall => _language == 'ar' ?
    GoogleFonts.getFont(
        'Cairo',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 12.0,
      ) : GoogleFonts.getFont(
        'DM Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 12.0,
      );
      //////////////////////////////
}

class DarkModeTheme extends AppTheme {

  late Color primary = const Color(0xFF4B986C);
  late Color secondary = const Color(0xFF928163);
  late Color tertiary = const Color(0xFF6D604A);
  late Color alternate = const Color(0xFF17282E);
  late Color primaryText = const Color(0xFFFFFFFF);
  late Color secondaryText = const Color(0xFF658593);
  late Color primaryBackground = const Color(0xFF0B191E);
  late Color secondaryBackground = const Color(0xFF0D1E23);
  late Color accent1 = const Color(0x4D4B986C);
  late Color accent2 = const Color(0x4D928163);
  late Color accent3 = const Color(0x4C6D604A);
  late Color accent4 = const Color(0xB20B191E);
  late Color success = const Color(0xFF336A4A);
  late Color warning = const Color(0xFFF3C344);
  late Color error = const Color(0xFFC4454D);
  late Color info = const Color(0xFFFFFFFF);
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    required String fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    FontStyle? fontStyle,
    bool useGoogleFonts = true,
    TextDecoration? decoration,
    double? lineHeight,
    List<Shadow>? shadows,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              letterSpacing: letterSpacing ?? this.letterSpacing,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
              decoration: decoration,
              height: lineHeight,
              shadows: shadows,
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              letterSpacing: letterSpacing,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              decoration: decoration,
              height: lineHeight,
              shadows: shadows,
            );
}
