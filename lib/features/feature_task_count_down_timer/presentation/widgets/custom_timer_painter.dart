import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';
import 'dart:math' as math;

class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({
    required this.borderThickness,
    required this.borderColor,
    required this.animation,
    required this.backgroundColor,
    required this.color,
    required this.iconColor,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color, iconColor, borderColor;
  final double borderThickness;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);

    // Draw a dotted border inside the circle
    final innerRadius = size.width / 2.0 -
        20.0; // Adjust this value to change the distance of the border from the edge of the circle
    final innerCircleRect =
        Rect.fromCircle(center: size.center(Offset.zero), radius: innerRadius);

    // Define the path for the dotted border
    final innerCirclePath = Path()
      ..addArc(innerCircleRect, math.pi * 1.5,
          -progress); // Use the same progress value as the main circle

    // Create a dashed version of the path
    final dashedPath = dashPath(innerCirclePath,
        dashArray: CircularIntervalList<double>(<double>[
          12.0,
          6.0
        ])); // Adjust these values to change the appearance of the dashes

    // Define the paint for the border
    final borderPaint = Paint()
      ..color = borderColor // Use the borderColor
      ..strokeWidth = borderThickness // Use the borderThickness
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    // Draw the dashed path with the border paint
    canvas.drawPath(dashedPath, borderPaint);

    // Draw the circular icon at the end of the arc
    var iconRadius = 12.0; // Adjust this value to change the size of the icon
    var iconCenter = size.center(Offset.zero) +
        Offset((size.width / 2) * math.cos(math.pi * 1.5 - progress),
            (size.width / 2) * math.sin(math.pi * 1.5 - progress));

    // Draw the white border
    paint
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth =
          3.0; // Adjust this value to change the thickness of the border
    canvas.drawCircle(iconCenter, iconRadius, paint);

    // Draw the fill color
    paint
      ..color = iconColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(iconCenter, iconRadius - paint.strokeWidth / 2,
        paint); // Subtract half the stroke width from the radius to ensure the border fits in
  }

  @override
  bool shouldRepaint(CustomTimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor ||
        iconColor != old.iconColor;
  }
}
