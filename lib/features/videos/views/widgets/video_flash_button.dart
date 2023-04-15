import 'package:flutter/material.dart';

class VideoFlashButton extends StatelessWidget {
  final bool isCurrentFlashMode;
  final onPressed;
  final IconData icon;
  const VideoFlashButton({
    super.key,
    required this.isCurrentFlashMode,
    this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: isCurrentFlashMode ? Colors.amber : Colors.white,
      onPressed: onPressed,
      icon: Icon(
        icon,
      ),
    );
  }
}
