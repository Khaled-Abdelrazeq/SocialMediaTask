import 'package:flutter/material.dart';

import '../../globals/app_enums.dart';
import '../../globals/color.dart';
import '../../globals/logic_utilities.dart';

class AppText extends StatelessWidget {
  const AppText({
    super.key,
    this.text,
    this.textColor,
    this.fontSize,
    this.alignment = Alignment.center,
    this.textAlign,
    this.textDecoration,
    this.textDecorationColor,
    this.fontsWeight,
    this.maxLines = 2,
    this.height,
  });

  final String? text;
  final Color? textColor;
  final Color? textDecorationColor;
  final double? fontSize;
  final dynamic alignment;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final FontsWeight? fontsWeight;
  final int maxLines;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(
        text ?? '',
        maxLines: maxLines,
        textAlign: textAlign ?? TextAlign.left,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          height: height,
          color: textColor ?? AppColors.fontColor,
          fontSize: fontSize ?? 18,
          decoration: textDecoration ?? TextDecoration.none,
          decorationColor: textDecorationColor,
          fontWeight: LogicUtilities.getFontWeight(fontsWeight),
        ),
      ),
    );
  }
}
