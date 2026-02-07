import 'package:flutter/material.dart';

class CustomTrackShape extends RectangularSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackLeft = offset.dx;
    final trackTop =
        offset.dy + (parentBox.size.height - sliderTheme.trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    final trackHeight = sliderTheme.trackHeight!;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
