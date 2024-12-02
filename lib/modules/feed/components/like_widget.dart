import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../globals/app_enums.dart';
import '../../../globals/app_icons.dart';
import '../../../globals/color.dart';
import '../../components/app_text.dart';

class LikeWidget extends StatefulWidget {
  const LikeWidget(
      {super.key, required this.onLikeTapped, required this.liked});

  final VoidCallback? onLikeTapped;
  final bool liked;

  @override
  State<LikeWidget> createState() => _LikeWidgetState();
}

class _LikeWidgetState extends State<LikeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller; // Animation controller
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200), // Animation duration
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse(); // Return to the original size
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward();
        if (widget.onLikeTapped != null) {
          widget.onLikeTapped!();
        }
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: SvgPicture.asset(
                    AppIcons.likeSvg,
                    width: 30,
                    color: widget.liked ? AppColors.primaryColor : null,
                  ),
                );
              },
            ),
            const SizedBox(width: 10),
            AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: AppText(
                    text: widget.liked ? 'Liked' : 'Like',
                    fontSize: 17,
                    fontsWeight: FontsWeight.medium,
                    textColor: widget.liked ? AppColors.primaryColor : null,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
