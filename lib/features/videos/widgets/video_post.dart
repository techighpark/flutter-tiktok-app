import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/common/widgets/video_configuration/video_config.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/widgets/video_button.dart';
import 'package:tiktok_clone/features/videos/widgets/video_comments.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

/**video post
 * [VideoPlayer]
 * [VisibilityDetector]
 * - onVisibilityChanged
 * Custom Animation
 * - [AnimatiionController]
 * - [SingleTickerProviderStateMixin]
 *  : Provides a single Ticker that is configured to only tick while the current tree is enabled, as defined by TickerMode.
 *  [TickerProvideerStateMixin] - multifple
 * - vsync: this
 *  : 위젯이 안 보일 때는 애니메이션 동작 prevent
 *  : prevent to waste resource
 * [AnimatedBuilder]
 */ ///

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

  final List<String> _hashtags = ['hash', 'tag', 'tiktok', 'wtf'];
  final String _text =
      'This is a very long text that will be truncated if it exceeds the container.';
  late bool _showMore;

  bool _isPaused = false;
  final bool _isMuted = true;
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
    await _videoPlayerController.setLooping(true);
    if (kIsWeb) {
      await _videoPlayerController.setVolume(0);
    }
    _videoPlayerController.addListener(_onVideoChange);
    setState(() {});
  }

// [Q] : why don't set state in addListener - video controller
// [Q] : why set state in addListener - animation controller
  void _initAnimation() {
    _animationController = AnimationController(
      // this = ticker
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _animationDuration,
    );
    // every time setState
    // _animationController.addListener(() {
    //   setState(() {});
    // });
  }

  void _initShowMore() {
    _showMore = _text.length < 30;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _initVideoPlayer();
    _initAnimation();
    _initShowMore();
  }

// [Q]: how to detect current video visibility?
  void _onVisibilityChange(VisibilityInfo info) {
    if (!mounted) return;
    if (info.visibleFraction == 1 &&
        !_videoPlayerController.value.isPlaying &&
        !_isPaused) {
      _videoPlayerController.play();
    }
    // 다른 offStage로 넘어갔을때
    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      _onTogglePause();
    }
  }

  void _onTogglePause() {
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

  void _onTextTap() {
    _showMore = !_showMore;

    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _onCommentTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _onTogglePause();
    }
    await showModalBottomSheet(
      context: context,
      // [WTF]
      // videoCommnets - size controll .. ListView or GridView ---- read document!
      // MediaQuery - Container - video_comments widget
      isScrollControlled: true,
      // barrierColor: Colors.red,
      // [WTF]
      backgroundColor: Colors.transparent,
      builder: (context) => const VideoComments(),
    );
    _onTogglePause();
  }

  // void _onMuteTap() {
  //   _isMuted = !_isMuted;
  //   if (_isMuted) {
  //     _videoPlayerController.setVolume(0);
  //   } else {
  //     _videoPlayerController.setVolume(20);
  //   }
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      // 화면에 보이는 게 바뀔대
      onVisibilityChanged: _onVisibilityChange,
      // Q
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
              onTap: _onTogglePause,
            ),
          ),
          // NOTICE: positioned - must be a child of Stack
          Positioned.fill(
            // 클릭 비활성화 - 왜 사용했지??
            child: IgnorePointer(
              child: Center(
                // 2nd method of animate
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      child: child,
                    );
                  },
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
            ),
          ),
          Positioned(
            left: 20,
            top: 40,
            child: IconButton(
              onPressed: VideoConfigData.of(context).toggleMuted,
              icon: FaIcon(
                VideoConfigData.of(context).autoMute
                    ? FontAwesomeIcons.volumeHigh
                    : FontAwesomeIcons.volumeOff,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '@xpzm',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v16,
                GestureDetector(
                  onTap: _onTextTap,
                  child: SizedBox(
                    width: 300,
                    child: Text(
                      'This is a very long text that will be truncated if it exceeds the container.',
                      overflow: _showMore
                          ? TextOverflow.visible
                          : TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: Sizes.size16,
                      ),
                    ),
                  ),
                ),
                Gaps.v16,
                Row(
                  children: [
                    for (String tag in _hashtags)
                      Row(
                        children: [
                          Text(
                            '#$tag',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: Sizes.size16,
                            ),
                          ),
                          Gaps.h2,
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            right: 20,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.black,
                  foregroundColor: Theme.of(context).primaryColor,
                  foregroundImage: const NetworkImage(
                      'https://avatars.githubusercontent.com/u/75081212?v=4'),
                  child: const Text('xpzm'),
                ),
                Gaps.v24,
                VideoButton(
                  icon: FontAwesomeIcons.solidHeart,
                  text: S.of(context).likeCount(123123),
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: () => _onCommentTap(context),
                  child: VideoButton(
                    icon: FontAwesomeIcons.solidComment,
                    text: S.of(context).commentCount(93938),
                  ),
                ),
                Gaps.v24,
                const VideoButton(
                  icon: FontAwesomeIcons.share,
                  text: "Share",
                ),
                // Gaps.v24,
                // GestureDetector(
                //   onTap: _onMuteTap,
                //   child: VideoButton(
                //     icon: _isMuted
                //         ? FontAwesomeIcons.volumeXmark
                //         : FontAwesomeIcons.volumeHigh,
                //     text: "Mute",
                //   ),
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
