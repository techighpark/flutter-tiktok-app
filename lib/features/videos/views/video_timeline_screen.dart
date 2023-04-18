import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/view_models/timeline_vm.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_post.dart';

// PageView.builder
// - scrollDirection
// - onPageChanged

class VideoTimelineScreen extends ConsumerStatefulWidget {
  const VideoTimelineScreen({super.key});
  @override
  createState() => VideoTimelineScreenState();
}

class VideoTimelineScreenState extends ConsumerState<VideoTimelineScreen> {
  int _itemCount = 4;

  final PageController _pageController = PageController();

  final Duration _scrollDuration = const Duration(milliseconds: 250);
  final Curve _scrollCurve = Curves.linear;

  void _onPageChanged(int page) {
    _pageController.animateToPage(
      page,
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
    if (page == _itemCount - 1) {
      _itemCount = _itemCount + 4;
      setState(() {});
    }
  }

  void _onVideoFinished() {
    return;
    _pageController.nextPage(
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future _onRefresh() {
    return Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(timelineProvider).when(
          data: (videos) => RefreshIndicator(
            semanticsLabel: 'abc',
            edgeOffset: 20,
            displacement: 400,
            backgroundColor: Colors.transparent,
            color: Theme.of(context).primaryColor,
            onRefresh: _onRefresh,
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              onPageChanged: _onPageChanged,
              itemCount: videos.length,
              itemBuilder: (context, index) => VideoPost(
                onVideoFinished: _onVideoFinished,
                index: index,
              ),
            ),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              'Could not load videos: $error',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        );
    // [WTF]
    // RefreshIndicator
  }
}
