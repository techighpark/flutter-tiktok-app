import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';

List<VideoModel> _list = [];

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  void uploadVideo() async {
    // loading state를 다시 trigger시키는 방법
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(seconds: 2));
    final newVideo = VideoModel(title: "${DateTime.now()}");
    _list = [..._list, newVideo];
    // AsyncNotifier라서
    state = AsyncValue.data(_list);
  }

  @override
  FutureOr<List<VideoModel>> build() async {
    // TODO: implement build
    await Future.delayed(const Duration(seconds: 2));

    return _list;
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(() {
  return TimelineViewModel();
});
