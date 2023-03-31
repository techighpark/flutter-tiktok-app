import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

class FormButton extends StatelessWidget {
  final bool disabled;
  final String text;
  const FormButton({super.key, required this.disabled, this.text = 'Next'});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.decelerate,
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: disabled
              ? isDarkMode(context)
                  ? Colors.grey.shade800
                  : Colors.grey.shade300
              : Theme.of(context).primaryColor,
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 500),
          style: TextStyle(
            color: disabled ? Colors.grey.shade400 : Colors.white,
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
