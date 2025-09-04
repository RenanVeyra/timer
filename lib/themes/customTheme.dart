import 'package:flutter/material.dart';

/// A minimal spec for your app's color theme.
@immutable
class ColorThemeSpec {
  final String id; // stable key, e.g. 'builtin-verdant-eclipse'
  final String name; // display name, e.g. 'Verdant Eclipse'
  final Color primary; // main accent (buttons, FAB)
  final Color secondary; // secondary accent (highlights)
  final Color background; // scaffold background
  final Color surface; // cards, sheets

  const ColorThemeSpec({
    required this.id,
    required this.name,
    required this.primary,
    required this.secondary,
    required this.background,
    required this.surface,
  });

  /// Map this spec to a ThemeData so widgets can react automatically.
  ThemeData toThemeData({Brightness brightness = Brightness.dark}) {
    final scheme = ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: Colors.white,
      secondary: secondary,
      onSecondary: Colors.white,
      background: background,
      onBackground: Colors.white,
      surface: surface,
      onSurface: Colors.white,
      error: const Color(0xFFB00020),
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.transparent, // we draw our own card
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: surface,
        contentTextStyle: const TextStyle(color: Colors.white),
      ),
    );
  }
}

// ===================== Built-in palettes =====================

const Color _blackEmerald = Color(0xFF122220);
const Color _burntAmber = Color(0xFFC4702A);
const Color _softCopper = Color(0xFFE29C56);
const Color _darkVerdant = Color(0xFF0D1A18);

/// Your five built-in presets (add more if you like)
const List<ColorThemeSpec> kBuiltinThemes = [
  ColorThemeSpec(
    id: 'builtin-verdant-eclipse',
    name: 'Verdant Eclipse',
    primary: _burntAmber,
    secondary: _softCopper,
    background: _blackEmerald,
    surface: _darkVerdant,
  ),
  // Example alternates – tweak as desired
  ColorThemeSpec(
    id: 'builtin-obsidian-forest',
    name: 'Obsidian Forest',
    primary: Color(0xFFD08C3A), // warmer amber
    secondary: Color(0xFFF0C27B), // lighter gold
    background: _blackEmerald,
    surface: Color(0xFF0F1E1B),
  ),
  ColorThemeSpec(
    id: 'builtin-deep-verdure',
    name: 'Deep Verdure',
    primary: Color(0xFFB8742F),
    secondary: Color(0xFFE6A86A),
    background: Color(0xFF0F1A18),
    surface: Color(0xFF0A1412),
  ),
  ColorThemeSpec(
    id: 'builtin-onyx-green',
    name: 'Onyx Green',
    primary: Color(0xFFC07A2E),
    secondary: Color(0xFFE1A560),
    background: Color(0xFF111F1D),
    surface: Color(0xFF0C1615),
  ),
  ColorThemeSpec(
    id: 'builtin-forest-noir',
    name: 'Forest Noir',
    primary: Color(0xFFBE792F),
    secondary: Color(0xFFE0A35E),
    background: Color(0xFF10211F),
    surface: Color(0xFF0B1716),
  ),
  ColorThemeSpec(
    id: 'builtin-cinder-flame',
    name: 'Cinder Flame',
    primary: Color(0xFF1E2B2F),
    secondary: Color(0xFF25383D),
    background: Color(0xFFFF7F50),
    surface: Color(0xFFFF9E73),
  ),
  ColorThemeSpec(
    id: 'builtin-ash-ember',
    name: 'Ash Ember',
    primary: Color(0xFFFF7F50),
    secondary: Color(0xFFE85E2C),
    background: Color(0xFF121A1C),
    surface: Color(0xFF1E2B2F),
  ),
  ColorThemeSpec(
    id: 'builtin-salmon-midnight',
    name: 'Salmon Midnight',
    primary: Color(0xFFE57A61), // Salmon
    secondary: Color(0xFFCC654F), // lighter salmon/gold
    background: Color(0xFF003C3F), // Midnight Green
    surface: Color(0xFF0A5E60), // lighter green for cards
  ),
];

/// Map by id for quick lookup.
final Map<String, ColorThemeSpec> kBuiltinThemeMap = {
  for (final t in kBuiltinThemes) t.id: t,
};

/// Resolve a ThemeData by id or by human-readable name.
ThemeData themeDataByKey(String key) {
  // Try id first
  final byId = kBuiltinThemeMap[key];
  if (byId != null) return byId.toThemeData();

  // Then try by name (case-insensitive)
  final lower = key.toLowerCase();
  final byName = kBuiltinThemes.firstWhere(
    (t) => t.name.toLowerCase() == lower,
    orElse: () => kBuiltinThemes.first,
  );
  return byName.toThemeData();
}

/// Convenience: the default theme your app can start with.
final ThemeData kDefaultTheme = kBuiltinThemes.first.toThemeData();
