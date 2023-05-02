import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';
import 'package:tiktok_clone/features/videos/repos/videos_repo.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  late final VideosRepository _repository;
  List<VideoModel> _list = [];

  /// void uploadVideo() async {
  ///   // loading state를 다시 trigger시키는 방법
  ///   state = const AsyncValue.loading();
  ///   await Future.delayed(const Duration(seconds: 2));
  ///
  ///   dart
  ///   final newVideo = VideoModel(title: "${DateTime.now()}");
  ///   _list = [..._list];
  ///   // AsyncNotifier라서
  ///   state = AsyncValue.data(_list);
  /// }
  Future<List<VideoModel>> _fetchVideos({
    int? lastItemCreatedAt,
  }) async {
    final result =
        await _repository.fetchVideos(lastItemCreatedAt: lastItemCreatedAt);
    final videos = result.docs.map(
      (video) => VideoModel.fromJson(
        json: video.data(),
        videoId: video.id,
      ),
    );
    return videos.toList();
  }

  @override
  FutureOr<List<VideoModel>> build() async {
    // await Future.delayed(const Duration(seconds: 2));
    print('timeline_vm - build');
    _repository = ref.read(videoRepo);
    _list = await _fetchVideos(lastItemCreatedAt: null);

    /// newList.toList()를 바로 return 하지 않는 이유
    /// 이미 가져온 비디오들의 복사본을 유지하고 싶기 때문
    /// >> pagination 할 때 아이템들을 더 추가하고 싶기 때문
    /// >> list를 교체하지않고 아이템을 추가하려고
    return _list;
  }

  Future<void> fetchNextPage() async {
    final nextPage =
        await _fetchVideos(lastItemCreatedAt: _list.last.createdAt);
    state = AsyncValue.data([..._list, ...nextPage]);
  }

  Future<void> refresh() async {
    final videos = await _fetchVideos(lastItemCreatedAt: null);
    _list = videos;
    state = AsyncValue.data(videos);
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(() {
  return TimelineViewModel();
});
