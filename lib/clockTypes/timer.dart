import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Avoid name clash with `dart:async.Timer`.
/// This is the skeletal base for all clock templates (countdown, pomodoro, workout, etc.)
abstract class ClockTemplate {
  final String id; // uuid or unique key
  final String label; // display label
  final IconData icon; // for menus/lists
  final Duration
  defaultDuration; // initial duration (stopwatch can use Duration.zero)
  final bool hasEnd; // e.g., countdown/pomodoro true, stopwatch false

  const ClockTemplate({
    required this.id,
    required this.label,
    required this.icon,
    required this.defaultDuration,
    required this.hasEnd,
  });
}

/// Example concrete template (basic countdown).
class CountdownTemplate extends ClockTemplate {
  const CountdownTemplate({
    required super.id,
    super.label = 'Timer',
    super.icon = Icons.timer_outlined,
    super.defaultDuration = const Duration(minutes: 25),
  }) : super(hasEnd: true);
}

/// Minimal iOS-like radial duration selector (minutes:seconds).
/// - Drag around the circle to set minutes (0-59).
/// - Drag radially inward/outward to set seconds in 5s steps (0-55).
/// This is intentionally simple for scaffolding and can be styled later.
class RadialDurationPicker extends StatefulWidget {
  final Duration initial;
  final ValueChanged<Duration> onChanged;
  final double size;

  const RadialDurationPicker({
    super.key,
    required this.initial,
    required this.onChanged,
    this.size = 260,
  });

  @override
  State<RadialDurationPicker> createState() => _RadialDurationPickerState();
}

class _RadialDurationPickerState extends State<RadialDurationPicker> {
  late int _minutes; // 0..59
  late int _seconds; // 0..59 (we'll snap to 5s)

  @override
  void initState() {
    super.initState();
    _minutes = widget.initial.inMinutes % 60;
    _seconds = widget.initial.inSeconds % 60;
    _seconds -= _seconds % 5; // snap to 5s
  }

  void _emit() {
    widget.onChanged(Duration(minutes: _minutes, seconds: _seconds));
  }

  void _onDrag(Offset local, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final v = local - center;
    final angle =
        (math.atan2(v.dy, v.dx) + math.pi * 1.5) % (2 * math.pi); // 0 at top
    final radius = v.distance;
    final outer = size.width / 2;
    final inner = outer * 0.55;

    // Minutes from angle (0..59)
    final minute = ((angle / (2 * math.pi)) * 60).round() % 60;

    // Seconds from radial distance (snap to 5s)
    final t = ((radius - inner) / (outer - inner)).clamp(0.0, 1.0);
    final sec = (t * 60).round();
    final snapped = (sec ~/ 5) * 5; // 0,5,10,...55

    setState(() {
      _minutes = minute;
      _seconds = snapped;
    });
    _emit();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size;
    return SizedBox(
      width: size,
      height: size,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final s = Size(constraints.maxWidth, constraints.maxHeight);
          return GestureDetector(
            onPanDown: (d) => _onDrag(d.localPosition, s),
            onPanUpdate: (d) => _onDrag(d.localPosition, s),
            child: CustomPaint(
              painter: _DialPainter(minutes: _minutes, seconds: _seconds),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${_minutes.toString().padLeft(2, '0')}:${_seconds.toString().padLeft(2, '0')}',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Drag around to set minutes\nDrag in/out to set seconds (5s steps)',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DialPainter extends CustomPainter {
  final int minutes; // 0..59
  final int seconds; // snapped 0..55
  _DialPainter({required this.minutes, required this.seconds});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerR = size.width / 2;
    final innerR = outerR * 0.55;

    final bg = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    final active = Paint()
      ..color = Colors.white.withOpacity(0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    // Outer circle (minutes)
    canvas.drawCircle(center, outerR - 8, bg);
    final minuteAngle = (minutes / 60) * 2 * math.pi;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: outerR - 8),
      -math.pi / 2, // start at top
      minuteAngle,
      false,
      active,
    );

    // Knob for minutes
    final knobR = 6.0;
    final knobX =
        center.dx + (outerR - 8) * math.cos(-math.pi / 2 + minuteAngle);
    final knobY =
        center.dy + (outerR - 8) * math.sin(-math.pi / 2 + minuteAngle);
    canvas.drawCircle(Offset(knobX, knobY), knobR, active);

    // Inner circle (seconds bands)
    final secAngle = (seconds / 60) * 2 * math.pi;
    final innerBg = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    canvas.drawCircle(center, innerR, innerBg);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: innerR),
      -math.pi / 2,
      secAngle,
      false,
      active,
    );
  }

  @override
  bool shouldRepaint(covariant _DialPainter old) =>
      old.minutes != minutes || old.seconds != seconds;
}
