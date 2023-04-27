import 'package:flutter/widgets.dart';

//ChangeNotifier(notifyListeners) + AnimatedBuilder
//ChangeNotifier(notifyListeners) + eventListener
//only necessary parts need to be rebuilt.
//it is suitable for apps with 5-10 screens.
class VideoConfigNoti extends ChangeNotifier {
  bool autoMute = false;

  void toggleAutoMute() {
    autoMute = !autoMute;
    notifyListeners();
  }
}

final videoConfigNoti = VideoConfigNoti();
