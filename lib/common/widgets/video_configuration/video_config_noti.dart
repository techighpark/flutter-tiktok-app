import 'package:flutter/widgets.dart';

class VideoConfigNoti extends ChangeNotifier {
  bool autoMute = false;
  void toggleAutoMute() {
    autoMute = !autoMute;
    notifyListeners();
  }
}

final videoConfigNoti = VideoConfigNoti();
