import 'package:flutter/material.dart';

class PersonIconWidget extends StatelessWidget {
  const PersonIconWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsetsDirectional.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey),
        ),
        child: const Icon(Icons.person));
  }
}
