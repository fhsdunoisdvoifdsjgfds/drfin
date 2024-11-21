import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SVGWidgett extends StatelessWidget {
  const SVGWidgett(
    this.assetName, {
    super.key,
    this.color,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  final String assetName;
  final Color? color;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      colorFilter: color != null
          ? ColorFilter.mode(
              color!,
              BlendMode.srcIn,
            )
          : null,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
