import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/video_preview_screen.dart';
import 'package:tiktok_clone/features/videos/widgets/video_flash_button.dart';

// enum FlashMode { off, auto, always, torch }
final List<dynamic> flashButtons = [
  {
    "flashMode": FlashMode.off,
    "icon": Icons.flash_off_rounded,
  },
  {
    "flashMode": FlashMode.always,
    "icon": Icons.flash_on_rounded,
  },
  {
    "flashMode": FlashMode.auto,
    "icon": Icons.flash_auto_rounded,
  },
  {
    "flashMode": FlashMode.torch,
    "icon": Icons.flashlight_on_rounded,
  },
];

class VideoRecordingScreen extends StatefulWidget {
  static const String routeName = "postVideo";
  static const String routeUrl = "/upload";
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool _hasPermission = false;
  bool _isSelfieMode = false;
  // debug mode and isIOS = camera off
  late final bool _noCamera = kDebugMode && Platform.isIOS;

  bool _isCameraInitialized = false;
  late bool _isTorchAvailable = true;

  late CameraController _cameraController;

  late final AnimationController _buttonAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(microseconds: 200),
  );
  late final Animation<double> _buttonAnimation =
      Tween(begin: 1.0, end: 1.2).animate(_buttonAnimationController);

  late final AnimationController _progressAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
    lowerBound: 0.0,
    upperBound: 1.0,
  );

  bool isCurrentFlashMode(FlashMode flashMode) {
    return _cameraController.value.flashMode == flashMode;
  }

  Future<void> _setSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    setState(() {});
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      return;
    } else {
      _cameraController = CameraController(
        cameras[_isSelfieMode ? 1 : 0],
        ResolutionPreset.ultraHigh,
        // audio 끄면 emulator에서 재생 가능함
        // enableAudio: false,
      );
      await _cameraController.initialize();
      // only for iOS
      // 가끔 영상과 오디오 싱크가 맞지 않음
      await _cameraController.prepareForVideoRecording();
      if (_cameraController.value.isInitialized) {
        _isCameraInitialized = true;
        _isTorchAvailable = _cameraController.description.lensDirection ==
            CameraLensDirection.back;
      } else {
        _isCameraInitialized = false;
      }
    }
    setState(() {});
  }

  Future<void> initPermission() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied) {
      _hasPermission = true;
      await initCamera();
      setState(() {});
    }
  }

  Future<void> _startRecording(TapDownDetails _) async {
    if (_cameraController.value.isRecordingVideo) return;
    await _cameraController.startVideoRecording();
    _buttonAnimationController.forward();
    _progressAnimationController.forward();
  }

  Future<void> _stopRecording() async {
    if (!_cameraController.value.isRecordingVideo) return;
    _buttonAnimationController.reverse();
    _progressAnimationController.reset();
    final XFile video = await _cameraController.stopVideoRecording();

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: false,
        ),
      ),
    );
  }

  Future<void> _onPickVideoPressed() async {
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );
    if (video == null) return;
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: true,
        ),
      ),
    );
  }

  Future<void> _onVerticalDragUpdate(DragUpdateDetails details) async {
    if (!_cameraController.value.isInitialized) {
      return;
    } else {
      final double max = await _cameraController.getMaxZoomLevel();
      final double min = await _cameraController.getMinZoomLevel();
      if (!mounted) return;
      final double height = MediaQuery.of(context).size.height * 0.8;
      double currentHeight = -details.localPosition.dy;
      double scale = (currentHeight / height) * max;

      if (scale >= max) {
        scale = max;
      } else if (scale <= min) {
        scale = min;
      }

      await _cameraController.setZoomLevel(scale);
    }
    // setState(() {});
  }

  @override
  void initState() {
    super.initState();
    if (!_noCamera) {
      initPermission();
    } else {
      setState(() {
        _hasPermission = true;
      });
    }
    WidgetsBinding.instance.addObserver(this);
    _progressAnimationController.addListener(() {
      setState(() {});
    });
    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRecording();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _buttonAnimationController.dispose();
    _progressAnimationController.dispose();
    if (!_noCamera) {
      _cameraController.dispose();
    }
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (_noCamera) return;
    if (!_hasPermission) return;
    if (!_cameraController.value.isInitialized) return;
    if (state == AppLifecycleState.inactive &&
        _cameraController.value.isRecordingVideo) {
      _cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      await initCamera();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: !_hasPermission
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text('Initializing...'),
                  Gaps.v16,
                  CircularProgressIndicator.adaptive(),
                ],
              )
            : Stack(
                alignment: Alignment.topCenter,
                children: [
                  if (!_noCamera && _cameraController.value.isInitialized)
                    CameraPreview(_cameraController),
                  const Positioned(
                    top: Sizes.size40,
                    left: Sizes.size20,
                    child: CloseButton(),
                  ),
                  if (!_noCamera)
                    Positioned(
                      top: Sizes.size60,
                      right: Sizes.size20,
                      child: Column(
                        children: [
                          IconButton(
                            color: Colors.white,
                            onPressed: _setSelfieMode,
                            icon: const Icon(
                              Icons.cameraswitch,
                            ),
                          ),
                          for (var button in flashButtons)
                            if (button['flashMode'] != FlashMode.torch ||
                                (button['flashMode'] == FlashMode.torch &&
                                    _isTorchAvailable))
                              VideoFlashButton(
                                isCurrentFlashMode:
                                    isCurrentFlashMode(button['flashMode']),
                                onPressed: () =>
                                    _setFlashMode(button['flashMode']),
                                icon: button['icon'],
                              ),
                        ],
                      ),
                    ),
                  Positioned(
                    bottom: Sizes.size52,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        const Spacer(),
                        GestureDetector(
                          onTapDown: _startRecording,
                          onTapUp: (details) => _stopRecording(),
                          // dragStartBehavior: DragStartBehavior.start,
                          onPanUpdate: _onVerticalDragUpdate,
                          // onVerticalDragUpdate: _onVerticalDragUpdate,
                          child: ScaleTransition(
                            scale: _buttonAnimation,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: Sizes.size80 + Sizes.size5,
                                  height: Sizes.size80 + Sizes.size5,
                                  child: CircularProgressIndicator(
                                    color: Colors.red.shade400,
                                    strokeWidth: Sizes.size4,
                                    value: _progressAnimationController.value,
                                  ),
                                ),
                                Container(
                                  width: Sizes.size72,
                                  height: Sizes.size72,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 3,
                                    ),
                                    color: Colors.red.shade500,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: IconButton(
                              onPressed: _onPickVideoPressed,
                              icon: const FaIcon(
                                FontAwesomeIcons.images,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
