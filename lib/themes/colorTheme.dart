// ignore_for_file: non_constant_identifier_names, prefer_final_fields

import 'package:flutter/material.dart';

class Colortheme {
  late Color _foreground_theme = Color(0xFFC4702A);
  late Color _background_theme = Color(0xFF122220);
  late Color _depth_accent = Color(0xFF0D1A18);
  late Color _secondary_accent = Color(0xFFE29C56);

  colorTheme({
    required Color foreground_theme,
    required Color background_theme,
    required Color depth_accent,
    required Color secondary_accent,
  }) => {};

  Color get app_background_theme => _background_theme;
  Color get app_foreground_theme => _foreground_theme;
  Color get app_depth_accent => _depth_accent;
  Color get app_secondary_accent => _secondary_accent;
}
