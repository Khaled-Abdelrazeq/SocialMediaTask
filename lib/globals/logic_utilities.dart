import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_media_task/globals/app_constants.dart';
import 'package:social_media_task/models/post.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../modules/components/dialog_action.dart';
import '../services/app/dialog_service.dart';
import '../services/app/snack_bar_service.dart';
import 'app_enums.dart';
import 'color.dart';

class LogicUtilities {
  static final SnackBarService snackBarService = SnackBarService();

  LogicUtilities._();

  /// Copy text to in the system OS
  static copy(String text, BuildContext context) {
    Clipboard.setData(ClipboardData(text: text)).then((value) =>
        snackBarService.showSuccess(context, message: 'Copied!', seconds: 1));
  }

  static void unFocusKeyboard(BuildContext context) {
    Focus.of(context).unfocus();
  }

  static FontWeight getFontWeight(FontsWeight? fontsWeight) {
    return fontsWeight == FontsWeight.extraBold
        ? FontWeight.w800
        : fontsWeight == FontsWeight.bold
            ? FontWeight.w700
            : fontsWeight == FontsWeight.semiBold
                ? FontWeight.w600
                : fontsWeight == FontsWeight.medium
                    ? FontWeight.w500
                    : fontsWeight == FontsWeight.regular
                        ? FontWeight.w400
                        : fontsWeight == FontsWeight.light
                            ? FontWeight.w300
                            : FontWeight.w300;
  }

  static bool isValidateEmail(String? value) {
    const pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    final regex = RegExp(pattern);

    return (value!.isNotEmpty && regex.hasMatch(value));
  }

  static bool isValidatePassword(String value) {
    return value.length >= 6;
  }

  static String getPostTime(DateTime? dateTime) {
    if (dateTime != null) {
      return timeago.format(dateTime, locale: 'en_short');
    }
    return '';
  }

  static String generateID({int length = 18}) {
    const characters =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();

    return List.generate(
            length, (index) => characters[random.nextInt(characters.length)])
        .join();
  }

  static bool ifUserLikedPost(PostModel post) {
    bool isLiked =
        post.likes?.contains(AppConstants.savedUserModel?.id) ?? false;
    print(
        "isLiked: $isLiked, ${post.likes}, ${AppConstants.savedUserModel?.id}");
    return isLiked;
  }

  static List<PostModel> sortPosts(List<PostModel> posts) {
    posts.sort((a, b) {
      double aLikeScore = AppConstants.likesWeight * (a.likes?.length ?? 0);
      double bLikeScore = AppConstants.likesWeight * (b.likes?.length ?? 0);

      DateTime now = DateTime.now();
      double aRecentScore = AppConstants.recentWeight *
          (1 / max(1, now.difference(a.createdAt ?? now).inSeconds.toDouble()));
      double bRecentScore = AppConstants.recentWeight *
          (1 / max(1, now.difference(b.createdAt ?? now).inSeconds.toDouble()));

      double aScore = aLikeScore + aRecentScore;
      double bScore = bLikeScore + bRecentScore;

      return bScore.compareTo(aScore); // Descending order
    });
    return posts;
  }

  static void showDeleteDialog(
      {required BuildContext context, onDeleteTapped, onCancelTapped}) {
    DialogService().showAlertDialog(
      context,
      'Are you sure you want to delete this post',
      actions: [
        DialogAction(
          label: 'Delete',
          onTap: onDeleteTapped,
        ),
        DialogAction(
          label: 'Cancel',
          textColor: AppColors.primaryColor,
          onTap: onCancelTapped,
        ),
      ],
    );
  }
}
