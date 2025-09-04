import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timer/themes/colorTheme.dart';

final Color _main_foreground_theme = Colortheme().app_foreground_theme;
final Color _main_background_theme = Colortheme().app_background_theme;
final Color _main_depth_accent = Colortheme().app_depth_accent;
final Color _main_secondary_accent = Colortheme().app_secondary_accent;

void _showClockPicker(BuildContext context, ValueChanged<ClockType> onSelect) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) {
      final items = ClockType.values;
      return Align(
        alignment: Alignment.bottomCenter,
        child: SafeArea(
          minimum: const EdgeInsets.only(bottom: 48),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Container(
              decoration: BoxDecoration(
                color: _main_depth_accent,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                  bottom: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: items.map((type) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.pop(context);
                      onSelect(type);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 4,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            type.icon,
                            size: 20,
                            color: _main_foreground_theme,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            type.label,
                            style: TextStyle(color: _main_foreground_theme),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      );
    },
  );
}
// ignore: file_names

enum ClockType {
  timer(label: 'Timer', icon: Icons.timer_outlined, id: 0),
  stopwatch(label: 'Stopwatch', icon: Icons.watch_later_outlined, id: 1),
  pomodoro(label: 'Pomodoro', icon: Icons.book, id: 2);

  final String label;
  final IconData icon;
  final int id;
  const ClockType({required this.label, required this.icon, required this.id});
}

class Displayscreen extends ConsumerWidget {
  const Displayscreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: _main_background_theme,
      appBar: AppBar(title: const Text('Example')),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 32.0),
        child: FloatingActionButton(
          backgroundColor: _main_foreground_theme,
          foregroundColor: _main_depth_accent,
          onPressed: () {
            _showClockPicker(context, (type) {
              // TODO: handle selected type (create model, navigate, etc.)
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
