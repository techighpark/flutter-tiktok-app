import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ProfilePost extends StatelessWidget {
  const ProfilePost({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(Sizes.size6),
      child: Column(
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 9 / 12,
                child: FadeInImage.assetNetwork(
                    fit: BoxFit.cover,
                    placeholder: 'assets/images/image5.jpg',
                    image:
                        'https://images.unsplash.com/photo-1614620027003-8800eebb10f7?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1172&q=80'),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size2,
                    vertical: Sizes.size4,
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.play_arrow_outlined,
                        color: Colors.white,
                        size: Sizes.size28,
                      ),
                      Text(
                        '4.1M',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: Sizes.size16,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
