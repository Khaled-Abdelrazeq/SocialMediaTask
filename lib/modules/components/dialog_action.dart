import 'package:flutter/material.dart';

import 'app_text.dart';

class DialogAction extends StatelessWidget {
  const DialogAction({
    super.key,
    required this.label,
    this.onTap,
    this.textColor,
  });

  final String label;
  final VoidCallback? onTap;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: AppText(
          text: label,
          textColor: textColor ?? Colors.red,
        ),
      ),
    );
  }
}
