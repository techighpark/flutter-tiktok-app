import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/playback_config_model.dart';
import 'package:tiktok_clone/features/videos/repos/video_playback_config_repo.dart';

/// notifier has state for exposing to my user
///
/// T(PlaybackConfigModel) -> state
class PlaybackConfigViewModel extends Notifier<PlaybackConfigModel> {
  final VideoPlaybackConfigRepository _repository;

  /// late final PlaybackConfigModel _model = PlaybackConfigModel(
  /// muted: _repository.isMuted(),
  /// autoplay: _repository.isAutoplay(),
  /// );

  /// constructor
  PlaybackConfigViewModel(this._repository);

  /// initial data of state
  @override
  PlaybackConfigModel build() {
    return PlaybackConfigModel(
      muted: _repository.isMuted(),
      autoplay: _repository.isAutoplay(),
    );
  }

  // get = read only
  // just provide

  /* bool get muted => _model.muted;
  bool get autoplay => _model.autoplay;*/

  /// this method set muted value
  ///
  /// [value] muted value
  ///  void
  void setMuted(bool value) {
    _repository.setMuted(value);
    state = PlaybackConfigModel(
      muted: value,
      autoplay: state.autoplay,
    );
    /*  _model.muted = value;
     notifyListeners();*/
  }

  void setAutoplay(bool value) {
    _repository.setAutoplay(value);
    state = PlaybackConfigModel(
      muted: state.muted,
      autoplay: value,
    );
  }
}

///Finally, we are using NotifierProvider to allow the UI to interact with
///our PlaybackConfigNotifier class.
///
///Due to need to get repository for parameter, throw error
final playbackConfigProvider =
    NotifierProvider<PlaybackConfigViewModel, PlaybackConfigModel>(() {
  throw UnimplementedError();
});
