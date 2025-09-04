import 'dart:ui';

enum CustomColor {
  obsidian_forest(
    label: 'Obsidian Forest',
    ColorTheme(
      Color(0xFFC4702A),
      Color(0xFF122220),
      Color(0xFF0D1A18),
      Color(0xFFE29C56),
    ),
  ),
}

final theme_list = Map<Colortheme>.filled(, Colortheme(), growable: false);

class Colortheme {
  late Color _foreground_theme; //Color(0xFFC4702A);
  late Color _background_theme; //Color(0xFF122220);
  late Color _depth_accent; //Color(0xFF0D1A18);
  late Color _secondary_accent; //Color(0xFFE29C56);

  ColorTheme(
    Color foreground_theme,
    Color background_theme,
    Color depth_accent,
    Color secondary_accent,
   ) => {
    _background_theme = background_theme,
    _foreground_theme = foreground_theme,
    _depth_accent = depth_accent,
    _secondary_accent = secondary_accent,
  };

  Color get app_background_theme => _background_theme;
  Color get app_foreground_theme => _foreground_theme;
  Color get app_depth_accent => _depth_accent;
  Color get app_secondary_accent => _secondary_accent;
}
