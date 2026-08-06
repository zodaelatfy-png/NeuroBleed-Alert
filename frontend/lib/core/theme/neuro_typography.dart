import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'neuro_colors.dart';

class NeuroTypography {
  static TextTheme get textTheme => GoogleFonts.outfitTextTheme().copyWith(
    displayLarge: GoogleFonts.outfit(
      fontSize: 57,
      fontWeight: FontWeight.bold,
      color: NeuroColors.textPrimary,
      letterSpacing: -0.25,
    ),
    displayMedium: GoogleFonts.outfit(
      fontSize: 45,
      fontWeight: FontWeight.bold,
      color: NeuroColors.textPrimary,
    ),
    displaySmall: GoogleFonts.outfit(
      fontSize: 36,
      fontWeight: FontWeight.bold,
      color: NeuroColors.textPrimary,
    ),
    headlineLarge: GoogleFonts.outfit(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: NeuroColors.textPrimary,
    ),
    titleLarge: GoogleFonts.outfit(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: NeuroColors.textPrimary,
    ),
    bodyLarge: GoogleFonts.outfit(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: NeuroColors.textPrimary,
    ),
    bodyMedium: GoogleFonts.outfit(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: NeuroColors.textSecondary,
    ),
    labelLarge: GoogleFonts.outfit(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: NeuroColors.textPrimary,
    ),
  );
}
