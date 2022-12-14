import 'package:flutter/material.dart';

import '../Screens/Utils/utils.dart';

class CustomMainButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final bool isLoading;
  final VoidCallback onPressed;
  const CustomMainButton(
      {super.key,
      required this.child,
      required this.color,
      required this.isLoading,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return ElevatedButton(
      onPressed: onPressed,
      child: !isLoading
          ? child
          : const Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: AspectRatio(aspectRatio: 1/1,
              child: CircularProgressIndicator(color: Colors.white),
            ),
          ),
      style: ElevatedButton.styleFrom(
        primary: color,
        fixedSize: Size(
          screenSize.width * 0.5,
          40,
        ),
      ),
    );
  }
}
