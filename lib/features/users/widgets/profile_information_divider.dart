import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ProfileInformationDivider extends StatelessWidget {
  const ProfileInformationDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      color: Colors.grey.shade400,
      width: Sizes.size32,
      thickness: Sizes.size1,
      indent: Sizes.size10,
      endIndent: Sizes.size10,
    );
  }
}
