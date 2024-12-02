import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../globals/app_enums.dart';
import '../../globals/color.dart';
import 'app_text.dart';
import 'app_text_form_field.dart';

class EditTextFormFieldWithLabel extends StatelessWidget {
  const EditTextFormFieldWithLabel({
    super.key,
    required this.label,
    required this.textController,
    this.hintText,
    this.isRequired = false,
    this.onChanged,
    this.obscureText,
    this.autoFillHints,
    this.inputFormatters,
    this.maxLines,
    this.onChangePassVisibility,
    this.height,
    this.width,
    this.maxLength,
    this.enabled = true,
    this.acceptAllCharacters,
    this.autofocus,
    this.inputType,
  });

  final String label;
  final TextEditingController? textController;
  final String? hintText;
  final bool isRequired;
  final Function(String)? onChanged;
  final VoidCallback? onChangePassVisibility;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final double? height;
  final double? width;
  final int? maxLength;
  final bool? acceptAllCharacters;
  final bool? obscureText;
  final bool enabled;
  final List<String>? autoFillHints;
  final bool? autofocus;
  final TextInputType? inputType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      child: Column(
        children: [
          if (label != '')
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppText(
                  text: label,
                  fontSize: 17,
                  fontsWeight: FontsWeight.semiBold,
                  textColor: AppColors.inputTextTitle,
                  alignment: AlignmentDirectional.centerStart,
                ),
                if (isRequired)
                  AppText(
                    text: ' *',
                    fontSize: 17,
                    textColor: AppColors.errorColor,
                  ),
              ],
            ),
          const SizedBox(height: 5),
          AppTextFormField(
            enabled: enabled,
            textController: textController,
            width: width,
            height: height,
            autofocus: autofocus,
            obscureText: obscureText,
            autoFillHints: autoFillHints,
            hintText: hintText,
            backgroundColor: AppColors.homeBgLightGrey,
            borderColor: AppColors.inputBorderColor,
            inputType: inputType ?? TextInputType.number,
            maxLines: obscureText != null ? 1 : maxLines,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
