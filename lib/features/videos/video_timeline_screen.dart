import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  int _itemCount = 4;
  List<Color> colors = [
    Colors.black,
    Colors.red,
    Colors.pink,
    Colors.blue,
  ];

  void _onPagechanged(int page) {
    if (page == _itemCount - 1) {
      _itemCount = _itemCount + 4;
      colors.addAll([
        Colors.black,
        Colors.red,
        Colors.pink,
        Colors.blue,
      ]);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      // pageSnapping: false,
      scrollDirection: Axis.vertical,
      itemCount: _itemCount,
      onPageChanged: _onPagechanged,
      itemBuilder: (context, index) => Container(
        color: colors[index],
        child: Center(
          child: Text(
            '$index',
            style: const TextStyle(
              fontSize: Sizes.size24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
