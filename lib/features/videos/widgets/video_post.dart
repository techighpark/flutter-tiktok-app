import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

// Video Player
// Visibility
// Custom Animation
//  - SingleTickerProviderStateMixin && vsync
//

class VideoPost extends StatefulWidget {
  final Function onVideoFinished;
  final int index;

  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.index,
  });

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/video.mp4");
  late final AnimationController _animationController;

  bool _isPaused = false;
  final Duration _animationDuration = const Duration(milliseconds: 200);

  void _onVideoChange() {
    VideoPlayerValue controllerValue = _videoPlayerController.value;
    if (controllerValue.isInitialized) {
      if (controllerValue.duration == controllerValue.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize();
    setState(() {});
    _videoPlayerController.addListener(_onVideoChange);
  }

  void _initAnimation() {
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _animationDuration,
    );
    // every time setState
    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
    _initAnimation();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

// QUESTION: how to detect current video visibility?
  void _onVisibilityChange(VisibilityInfo info) {
    if (info.visibleFraction == 1 && !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
    }
  }

  void _togglePause() {
    _videoPlayerController.value.isPlaying
        ? {
            _videoPlayerController.pause(),
            // reverse : upperbound -> lowerbound
            _animationController.reverse()
          }
        : {
            _videoPlayerController.play(),
            // forward : lowerbound -> upperbound
            _animationController.forward()
          };

    _isPaused = !_isPaused;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      onVisibilityChanged: _onVisibilityChange,
      key: Key("${widget.index}"),
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(
                    color: Colors.black,
                  ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _togglePause,
            ),
          ),
          // NOTICE: positioned - must be a child of Stack
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: Transform.scale(
                  scale: _animationController.value,
                  child: AnimatedOpacity(
                    duration: _animationDuration,
                    opacity: _isPaused ? 1 : 0,
                    child: FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white.withOpacity(0.8),
                      size: Sizes.size52,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
