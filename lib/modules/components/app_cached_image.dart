import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppCachedImage extends StatelessWidget {
  const AppCachedImage({
    super.key,
    this.width,
    this.height,
    this.imageUrl,
    this.boxFit,
    this.errorWidget,
    this.borderRadius,
  });

  final double? width;
  final double? height;
  final String? imageUrl;
  final BoxFit? boxFit;
  final Widget? errorWidget;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: CachedNetworkImage(
        imageUrl: imageUrl ?? '',
        width: width ?? 40,
        height: height,
        fit: boxFit ?? BoxFit.cover,
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) =>
            errorWidget ?? const Icon(Icons.error),
      ),
    );
  }
}
