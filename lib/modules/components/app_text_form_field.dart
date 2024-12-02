import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../globals/app_enums.dart';
import '../../globals/color.dart';
import '../../globals/logic_utilities.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    this.hintText,
    this.textController,
    this.prefix,
    this.suffix,
    this.onSave,
    this.backgroundColor,
    this.maxLines,
    this.height,
    this.inputType,
    this.obscureText,
    this.hasError = false,
    this.validator,
    this.hintColor,
    this.borderColor,
    this.paddingTop,
    this.enabled = true,
    this.inputFormatters,
    this.borderRadius,
    this.contentPadding,
    this.width,
    this.fontSize,
    this.onChanged,
    this.hintFontSize,
    this.hintFontWeight,
    this.onTap,
    this.autoFillHints,
    this.autofocus,
  });

  final String? hintText;
  final TextEditingController? textController;
  final Widget? prefix;
  final Widget? suffix;
  final VoidCallback? onSave;
  final Function(String)? onChanged;
  final Color? backgroundColor;
  final int? maxLines;
  final double? height;
  final TextInputType? inputType;
  final bool? obscureText;
  final bool hasError;
  final FormFieldValidator? validator;
  final bool enabled;
  final Color? hintColor;
  final Color? borderColor;
  final double? paddingTop;
  final List<TextInputFormatter>? inputFormatters;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final double? width;
  final double? hintFontSize;
  final double? fontSize;
  final FontsWeight? hintFontWeight;
  final VoidCallback? onTap;
  final List<String>? autoFillHints;
  final bool? autofocus;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey.shade100,
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
        border: Border.all(
            color: borderColor ??
                (hasError ? Colors.red : Colors.grey.withOpacity(0.4))),
      ),
      height: height ?? 56,
      child: TextFormField(
        onTap: onTap,
        autofillHints: autoFillHints,
        autocorrect: false,
        autofocus: autofocus ?? false,
        style: TextStyle(
            fontSize: fontSize ?? 18,
            color: AppColors.fontColor,
            fontWeight: LogicUtilities.getFontWeight(FontsWeight.semiBold)),
        maxLines: maxLines,
        validator: validator,
        obscureText: obscureText ?? false,
        controller: textController,
        readOnly: !enabled,
        onEditingComplete: onSave,
        onSaved: (_) => onSave,
        onChanged: onChanged,
        keyboardType: inputType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          contentPadding: contentPadding ??
              const EdgeInsetsDirectional.only(
                  start: 10, top: 6, bottom: 6, end: 10),
          hintText: hintText,
          // alignLabelWithHint: true,
          hintStyle: TextStyle(
            color: hintColor ?? AppColors.hintColor,
            fontSize: hintFontSize ?? 15,
            fontWeight: LogicUtilities.getFontWeight(
                hintFontWeight ?? FontsWeight.medium),
          ),
          border: InputBorder.none,
          prefixIcon: prefix,
          suffixIcon: suffix,
        ),
      ),
    );
  }
}
