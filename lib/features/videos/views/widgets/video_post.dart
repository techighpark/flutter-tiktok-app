import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktok_clone/features/videos/view_models/video_post_vm.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_button.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_comments.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// video post
/// [VideoPlayer]
/// [VisibilityDetector]
/// - onVisibilityChanged
/// Custom Animation
/// - [AnimationController]
/// - [SingleTickerProviderStateMixin]
///  : Provides a single Ticker that is configured to only tick while the current tree is enabled, as defined by TickerMode.
///  [TickerProviderStateMixin] - multiple
/// - vsync: this
///  : 위젯이 안 보일 때는 애니메이션 동작 prevent
///  : prevent to waste resource
/// [AnimatedBuilder]

class VideoPost extends ConsumerStatefulWidget {
  final Function onVideoFinished;
  final int index;
  final VideoModel videoData;

  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.index,
    required this.videoData,
  });

  @override
  createState() => VideoPostState();
}

class VideoPostState extends ConsumerState<VideoPost>
    with SingleTickerProviderStateMixin {
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/video.mp4");
  late final AnimationController _animationController;

  final List<String> _hashtags = ['hash', 'tag', 'tiktok', 'wtf'];
  final String _text =
      'This is a very long text that will be truncated if it exceeds the container.';
  late bool _showMore;
  late bool _currentMuted;

  // late bool _isLiked = ref.read();

  bool _isPaused = false;

  // final bool _isMuted = true;
  // final bool _autoMutedValue = videoConfigValue.value;
  final Duration _animationDuration = const Duration(milliseconds: 200);

  void _onVideoChange() {
    VideoPlayerValue controllerValue = _videoPlayerController.value;
    if (controllerValue.isInitialized) {
      if (controllerValue.duration == controllerValue.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _onLikeTap() {
    /// ref.read(videoPostProvider.notifier).likeVideo(videoId);
    ref.read(videoPostProvider(widget.videoData.id).notifier).toggleLikeVideo();
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

  void _initMuted() {
    _currentMuted = ref.read(playbackConfigProvider).muted;
    setState(() {});
  }

// [Q] : why don't set state in addListener - video controller
// [Q] : why set state in addListener - animation controller
  void _initAnimation() {
    _animationController = AnimationController(
      // this = ticker
      vsync: this,
      upperBound: 1.5,
      lowerBound: 1.0,
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

  // void _onPlaybackConfigChanged() {
  //   if (!mounted) return;

  //   if (ref.read(playbackConfigProvider).muted) {
  //     _videoPlayerController.setVolume(0);
  //   } else {
  //     _videoPlayerController.setVolume(1);
  //   }
  // }

// [Q]: how to detect current video visibility?
  void _onVisibilityChange(VisibilityInfo info) {
    if (!mounted) return;
    if (info.visibleFraction == 1 &&
        !_videoPlayerController.value.isPlaying &&
        !_isPaused) {
      // final autoplay = context.read<PlaybackConfigViewModel>().autoplay;

      if (ref.read(playbackConfigProvider).autoplay) {
        _videoPlayerController.play();
      }
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

  void _onMuteTap() {
    _currentMuted = !_currentMuted;
    if (_currentMuted) {
      _videoPlayerController.setVolume(0);
    } else {
      _videoPlayerController.setVolume(20);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _initVideoPlayer();
    _initAnimation();
    _initShowMore();
    _initMuted();
    // context
    //     .read<PlaybackConfigViewModel>()
    //     .addListener(_onPlaybackConfigChanged);

    // videoConfigNoti.addListener(() {
    //   setState(() {
    //     _autoMuted = videoConfigNoti.autoMute;
    //   });
    // });
    // videoConfigValue.addListener(() {
    //   setState(() {
    //     _autoMutedValue = videoConfigValue.value;
    //   });
    // });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      /// 화면에 보이는 게 바뀔대
      onVisibilityChanged: _onVisibilityChange,
      key: Key("${widget.index}"),
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Image.network(
                    widget.videoData.thumbnailUrl,
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _onTogglePause,
            ),
          ),

          /// NOTICE: positioned - must be a child of Stack
          Positioned.fill(
            /// 클릭 비활성화 - 왜 사용했지??
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
            child: Column(
              children: [
                IconButton(
                  icon: FaIcon(
                    _currentMuted
                        // context.watch<PlaybackConfigViewModel>().muted
                        ? FontAwesomeIcons.volumeOff
                        : FontAwesomeIcons.volumeHigh,
                    color: Colors.white,
                  ),
                  onPressed: () {
/*                    context.read<PlaybackConfigViewModel>().setMuted(
                        !context.read<PlaybackConfigViewModel>().muted);*/
                    _onMuteTap();
                  },
                ),
                // IconButton(
                //   onPressed: videoConfigNoti.toggleAutoMute,
                //   icon: FaIcon(
                //     _autoMuted
                //         ? FontAwesomeIcons.volumeHigh
                //         : FontAwesomeIcons.volumeOff,
                //     color: Colors.white,
                //   ),
                // ),
                // IconButton(
                //   onPressed: () {
                //     videoConfigValue.value = !videoConfigValue.value;
                //   },
                //   icon: FaIcon(
                //     _autoMutedValue
                //         ? FontAwesomeIcons.volumeHigh
                //         : FontAwesomeIcons.volumeOff,
                //     color: Colors.white,
                //   ),
                // ),
                // IconButton(
                //   onPressed: () {
                //     context.read<VideoConfigProvider>().toggleIsMuted();
                //   },
                //   icon: FaIcon(
                //     context.watch<VideoConfigProvider>().isMuted
                //         ? FontAwesomeIcons.volumeHigh
                //         : FontAwesomeIcons.volumeOff,
                //     color: Colors.white,
                //   ),
                // ),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '@${widget.videoData.creator}',
                  style: const TextStyle(
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
                      widget.videoData.description,
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
                  foregroundImage: ref.read(usersProvider).value!.hasAvatar
                      ? NetworkImage(
                          'https://firebasestorage.googleapis.com/v0/b/techigh-tiktok-dev-cli.appspot.com/o/avatars%2F${widget.videoData.creatorUid}?alt=media')
                      : null,
                  child: Text(widget.videoData.creator),
                ),
                Gaps.v24,
                ref.watch(videoPostProvider(widget.videoData.id)).when(
                      data: (data) {
                        return GestureDetector(
                          onTap: _onLikeTap,
                          child: VideoButton(
                            isOn: data['isLiked'],
                            icon: FontAwesomeIcons.solidHeart,
                            text: S.of(context).likeCount(data['likeCount']),
                          ),
                        );
                      },
                      loading: () => GestureDetector(
                        onTap: null,
                        child: VideoButton(
                          icon: Icons.favorite,
                          text: '${widget.videoData.likes}',
                        ),
                      ),
                      error: (error, stackTrace) => const SizedBox(),
                    ),
                Gaps.v24,
                GestureDetector(
                  onTap: () => _onCommentTap(context),
                  child: VideoButton(
                    icon: FontAwesomeIcons.solidComment,
                    text: S.of(context).commentCount(widget.videoData.comments),
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
