import 'package:flutter/material.dart';

class P extends EdgeInsets {
  const P({
    double? left,
    double? right,
    double? top,
    double? bottom,
    double? vertical,
    double? horizontal,
    double? all,
  }) : super.only(
          left: left ?? horizontal ?? all ?? 0.0,
          top: top ?? vertical ?? all ?? 0.0,
          right: right ?? horizontal ?? all ?? 0.0,
          bottom: bottom ?? vertical ?? all ?? 0.0,
        );

  static const EdgeInsets zero = EdgeInsets.zero;
}
