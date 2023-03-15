import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  void _onClosePressed() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size14),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          title: const Text('12312 commnets'),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey.shade50,
          actions: [
            IconButton(
              onPressed: _onClosePressed,
              icon: const FaIcon(
                FontAwesomeIcons.xmark,
              ),
            )
          ],
        ),
        body: ListView.separated(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size24,
            vertical: Sizes.size10,
          ),
          itemCount: 10,
          separatorBuilder: (context, index) => Gaps.v32,
          itemBuilder: (context, index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: Sizes.size20,
                  child: Text('xpzm'),
                ),
                Gaps.h12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'xpzm',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Sizes.size14,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      Gaps.v4,
                      Text(
                        'techigh take high, your can do! 😀 😀asfsfsafsdfasdfasfasfasfasfsafasfasfasfsa',
                        style: TextStyle(
                          fontSize: Sizes.size14,
                          color: Colors.grey.shade900,
                        ),
                      ),
                      Gaps.v4,
                      Text(
                        'techigh take high, your can do! 😀',
                        style: TextStyle(
                          fontSize: Sizes.size14,
                          color: Colors.grey.shade900,
                        ),
                      ),
                    ],
                  ),
                ),
                Gaps.h10,
                Column(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.heart,
                      color: Colors.grey.shade500,
                      size: Sizes.size20,
                    ),
                    Text(
                      '23.4K',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                      ),
                    )
                  ],
                )
              ],
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Row(
            children: [
              CircleAvatar(
                radius: Sizes.size20,
                backgroundColor: Colors.grey.shade500,
                foregroundColor: Colors.white,
                child: const Text('xpzm'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
