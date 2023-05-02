import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class InboxListTile extends StatelessWidget {
  final String title, subtitle;
  final IconData trailingIcon;
  final IconData leadingIcon;

  const InboxListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.trailingIcon,
    required this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: Sizes.size44,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
        child: Center(
          child: FaIcon(
            leadingIcon,
            color: Colors.white,
            size: Sizes.size20,
          ),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: Sizes.size12,
        ),
      ),
      trailing: FaIcon(
        trailingIcon,
        size: Sizes.size14,
        color: Colors.black,
      ),
    );
  }
}
