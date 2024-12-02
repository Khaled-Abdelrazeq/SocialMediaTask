import 'package:flutter/material.dart';
import 'package:social_media_task/globals/color.dart';

import '../../globals/app_enums.dart';
import '../../globals/logic_utilities.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.label,
    this.icon,
    this.onTap,
    this.iconColor,
    this.backgroundColor,
    this.width = 300,
    this.height = 40,
    this.fontSize = 14,
    this.textColor = Colors.white,
    this.withBorder = true,
    this.borderRadius,
    this.blurRadius = 10,
    this.fontWeight,
    this.boxShadow,
    this.onHover,
    this.borderColor,
    this.maxLines,
    this.borderWidth,
    this.iconSize,
  });
  final String? label;
  final Color? backgroundColor;
  final IconData? icon;
  final Color? iconColor;
  final VoidCallback? onTap;
  final double width;
  final double height;
  final double fontSize;
  final Color textColor;
  final bool withBorder;
  final double? borderRadius;
  final double blurRadius;
  final FontsWeight? fontWeight;
  final BoxShadow? boxShadow;
  final Function(bool?)? onHover;
  final Color? borderColor;
  final int? maxLines;
  final double? borderWidth;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
            color: borderColor ?? Colors.white,
            width: withBorder ? borderWidth ?? 1 : 0),
        borderRadius: BorderRadius.circular(borderRadius ?? 25),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? 25),
        child: Material(
          color: backgroundColor,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor ?? AppColors.primaryColor,
              disabledForegroundColor:
                  backgroundColor ?? AppColors.primaryColor.withOpacity(0.88),
              disabledBackgroundColor:
                  backgroundColor ?? AppColors.primaryColor.withOpacity(0.82),
              alignment: Alignment.center,
              textStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: LogicUtilities.getFontWeight(FontsWeight.bold),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: onTap,
            child: Text(
              '$label',
              maxLines: maxLines ?? 1,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                decoration: TextDecoration.none,
                fontWeight: LogicUtilities.getFontWeight(
                    fontWeight ?? FontsWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
