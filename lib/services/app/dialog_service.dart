import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_task/globals/app_enums.dart';
import 'package:social_media_task/modules/components/app_text.dart';

class DialogService {
  void showLoading(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              content: Container(
                height: 40,
                width: 40,
                color: Colors.white,
                child: SpinKitPulse(
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ),
        barrierDismissible: false);
  }

  void hideLoading(BuildContext context) {
    if (context.canPop()) context.pop();
  }

  Future<void> showAlertDialog(context, title,
      {List<Widget>? dialogBody,
      List<Widget>? actions,
      barrierDismissible = true}) async {
    return await showCupertinoDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return CupertinoAlertDialog(
            title: AppText(
              text: "$title",
              fontSize: 16,
              fontsWeight: FontsWeight.bold,
            ),
            actions: actions ?? [],
            content: SingleChildScrollView(
              child: ListBody(
                children: dialogBody ?? [],
              ),
            ),
          );
        });
  }
}
