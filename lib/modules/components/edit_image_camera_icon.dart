import 'package:flutter/material.dart';

import '../../globals/color.dart';

class EditImageCameraIcon extends StatelessWidget {
  const EditImageCameraIcon({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 1),
        ),
        child: const Icon(
          Icons.camera_alt,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
