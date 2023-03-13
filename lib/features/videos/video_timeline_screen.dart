import 'package:flutter/material.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  List<Color> colors = [
    Colors.black,
    Colors.red,
    Colors.pink,
    Colors.blue,
  ];
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      // pageSnapping: false,
      scrollDirection: Axis.vertical,
      itemCount: colors.length,
      itemBuilder: (context, index) => Container(
        color: colors[index],
      ),
    );
  }
}
