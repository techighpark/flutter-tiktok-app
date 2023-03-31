import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  bool _isWriting = false;
  final ScrollController _scrollController = ScrollController();

  void _onClosePressed() {
    Navigator.of(context).pop();
  }

// [WTF]
  void _onStopWriting() {
    FocusScope.of(context).unfocus();
    _isWriting = false;
  }

  void _onStartWriting() {
    _isWriting = true;
  }

  @override
  Widget build(BuildContext context) {
    // [WTF]
    // Screen Size
    final size = MediaQuery.of(context).size;
    final isDark = isDarkMode(context);
    return Container(
      // bottom sheet bar size
      height: size.height * 0.75,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Sizes.size14,
        ),
      ),
      child: Scaffold(
        backgroundColor: isDark ? null : Colors.grey.shade50,
        appBar: AppBar(
          title: const Text('12312 commnets'),
          // 뒤로가기 버튼
          automaticallyImplyLeading: false,
          backgroundColor: isDark ? null : Colors.grey.shade50,
          actions: [
            IconButton(
              onPressed: _onClosePressed,
              icon: const FaIcon(
                FontAwesomeIcons.xmark,
              ),
            )
          ],
        ),
        body: GestureDetector(
          onTap: _onStopWriting,
          child: Stack(
            children: [
              // scrollbar - depend on me
              Scrollbar(
                // 따라서, Scrollbar 위젯을 사용할 때 controller 속성을 지정하지 않아도 자동으로 연결되므로,
                //스크롤바를 사용할 때는 별도로 controller를 설정해줄 필요가 없습니다.
                // 하지만, Scrollbar 위젯의 controller 속성을 지정하면, 스크롤바의 위치와 크기를 직접 제어할 수 있습니다.
                //예를 들어, 스크롤바의 위치를 화면의 오른쪽에 고정하고 싶은 경우,
                //controller 속성을 사용하여 스크롤바의 위치를 직접 지정할 수 있습니다.
                controller: _scrollController,
                child: ListView.separated(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(
                    left: Sizes.size16,
                    right: Sizes.size16,
                    top: Sizes.size10,
                    bottom: Sizes.size10 + Sizes.size96,
                  ),
                  itemCount: 10,
                  separatorBuilder: (context, index) => Gaps.v32,
                  itemBuilder: (context, index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: Sizes.size20,
                          backgroundColor: isDark ? Colors.grey.shade600 : null,
                          child: const Text('xpzm'),
                        ),
                        Gaps.h12,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'xpzm',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Sizes.size14,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              Gaps.v4,
                              const Text(
                                'techigh take high, your can do! 😀 😀asfsfsafsdfasdfasfasfasfasfsafasfasfasfsa',
                                style: TextStyle(
                                  fontSize: Sizes.size14,
                                  // color: Colors.grey.shade900,
                                ),
                              ),
                              Gaps.v4,
                              const Text(
                                'flutter practice! 😀',
                                style: TextStyle(
                                  fontSize: Sizes.size14,
                                  // color: Colors.grey.shade900,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gaps.h10,
                        Column(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.heart,
                              color: Colors.grey.shade500,
                              size: Sizes.size20,
                            ),
                            Text(
                              '23.4K',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                              ),
                            )
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 0,
                width: size.width,
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: Sizes.size16,
                      right: Sizes.size16,
                      top: Sizes.size10,
                      bottom: Sizes.size40,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: Sizes.size20,
                          // backgroundColor: Colors.grey.shade500,
                          backgroundColor: isDark ? Colors.grey.shade600 : null,
                          // foregroundColor: Colors.white,
                          child: const Text('xpzm'),
                        ),
                        Gaps.h10,
                        // [WTF]
                        // inside SizedBox or Expanded
                        Expanded(
                          child: SizedBox(
                            height: Sizes.size40,
                            child: TextField(
                              onTap: _onStartWriting,
                              // return!
                              // [WTF]
                              // done -> retrun으로 바뀜
                              textInputAction: TextInputAction.newline,
                              // TextInputAction.newline -> minLines, maxLines, expands 필수
                              minLines: null,
                              maxLines: null,
                              expands: true,
                              // cursorColor: Theme.of(context).primaryColor,
                              style: const TextStyle(
                                fontSize: Sizes.size14,
                              ),
                              decoration: InputDecoration(
                                // focusColor: Colors.green,
                                // suffixIconColor: isDark
                                //     ? Colors.red.shade400
                                //     : Colors.red.shade600,
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                    right: Sizes.size14,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.at,
                                        size: Sizes.size16,
                                        color: isDark
                                            ? Colors.grey.shade400
                                            : Colors.grey.shade700,
                                      ),
                                      Gaps.h10,
                                      FaIcon(
                                        FontAwesomeIcons.gift,
                                        size: Sizes.size16,
                                        color: isDark
                                            ? Colors.grey.shade400
                                            : Colors.grey.shade700,
                                      ),
                                      Gaps.h10,
                                      FaIcon(
                                        FontAwesomeIcons.faceSmile,
                                        size: Sizes.size16,
                                        color: isDark
                                            ? Colors.grey.shade400
                                            : Colors.grey.shade700,
                                      ),
                                      Gaps.h10,
                                      // [WTF]
                                      // conditional button
                                      // if (_isWriting)
                                      AnimatedOpacity(
                                        opacity: _isWriting ? 1 : 0,
                                        duration: const Duration(
                                          milliseconds: 500,
                                        ),
                                        child: GestureDetector(
                                          onTap: _onStopWriting,
                                          child: FaIcon(
                                            FontAwesomeIcons.circleArrowUp,
                                            size: Sizes.size16,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                hintText: "Write a comment!",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    Sizes.size40,
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                // fillColor: Colors.grey.shade200,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.size20,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
