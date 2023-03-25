import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ProfileInformation extends StatelessWidget {
  const ProfileInformation({
    super.key,
    required this.informationCount,
    required this.informationTitle,
  });

  final dynamic informationCount;
  final String informationTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '$informationCount',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Sizes.size20,
          ),
        ),
        Gaps.v5,
        Text(
          informationTitle,
          style: TextStyle(
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}
