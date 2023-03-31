import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

class DiscoverPost extends StatelessWidget {
  const DiscoverPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(Sizes.size6),
      child: LayoutBuilder(
        builder: (context, constraints) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  Sizes.size4,
                ),
              ),
              child: AspectRatio(
                aspectRatio: 9 / 16,
                child: FadeInImage.assetNetwork(
                    fit: BoxFit.cover,
                    placeholder: 'assets/images/image5.jpg',
                    image:
                        'https://images.unsplash.com/photo-1614620027003-8800eebb10f7?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1172&q=80'),
              ),
            ),
            Gaps.v10,
            const Text(
              'Cajun chiken Alfredo,Cajun chiken Alfredo,Cajun chiken Alfredo,Cajun chiken Alfredo,Cajun chiken Alfredo,Cajun chiken Alfredo',
              style: TextStyle(
                fontSize: Sizes.size16,
                fontWeight: FontWeight.bold,
                height: 1.1,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Gaps.v5,
            Row(
              children: const [
                Text(
                  '#cooking',
                ),
                Text(
                  '#tiktok',
                ),
                Text(
                  '#food',
                ),
              ],
            ),
            Gaps.v5,
            // textstyle 통일
            // if (constraints.maxWidth < 210 || constraints.maxWidth > 250)
            DefaultTextStyle(
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isDarkMode(context)
                    ? Colors.grey.shade400
                    : Colors.grey.shade600,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: Sizes.size14,
                    backgroundColor: Colors.black,
                    foregroundColor: Theme.of(context).primaryColor,
                    foregroundImage: const NetworkImage(
                        'https://avatars.githubusercontent.com/u/75081212?v=4'),
                  ),
                  Gaps.h8,
                  const Expanded(
                    child: Text(
                      'My Avartar is going to be very long',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Gaps.h4,
                  FaIcon(
                    FontAwesomeIcons.heart,
                    size: Sizes.size16,
                    color: Colors.grey.shade500,
                  ),
                  Gaps.h4,
                  const Text(
                    '2.5M',
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
