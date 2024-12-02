import 'package:flutter/material.dart';
import 'package:social_media_task/modules/components/app_text.dart';

import '../../globals/color.dart';

class SnackBarService {
  void showError(BuildContext context,
      {required String message, int seconds = 3}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AppText(
          text: "Error: $message",
          textColor: Colors.white,
        ),
        duration: Duration(seconds: seconds),
        backgroundColor: Colors.red,
      ),
    );
  }

  void showSuccess(BuildContext context,
      {required String message, int seconds = 3}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AppText(
          text: "Successfully: $message",
          textColor: Colors.white,
        ),
        duration: Duration(seconds: seconds),
        backgroundColor: Colors.green,
      ),
    );
  }

  void showNotification(BuildContext context,
      {required String message, int seconds = 3, Color? textColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AppText(
          text: "Notification: $message",
          textColor: textColor ?? AppColors.notificationTextColor,
        ),
        duration: Duration(seconds: seconds),
        backgroundColor: AppColors.notificationBackgroundColor.withOpacity(0.5),
      ),
    );
  }
}
