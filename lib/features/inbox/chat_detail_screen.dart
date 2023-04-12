import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

class ChatDetailScreen extends StatefulWidget {
  static const String routeName = "chatDetail";
  // 자식 경로는 /로 시작할 수 없다.
  static const String routeUrl = ":chatId";
  final String chatId;
  const ChatDetailScreen({
    super.key,
    required this.chatId,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: ListTile(
          contentPadding: const EdgeInsets.only(
            right: Sizes.size20,
          ),
          horizontalTitleGap: Sizes.size10,
          leading: Stack(
            // alignment: AlignmentDirectional.bottomEnd,
            children: [
              const Padding(
                padding: EdgeInsets.zero,
                child: CircleAvatar(
                  radius: Sizes.size24,
                  child: Text('tech'),
                ),
              ),
              Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  width: Sizes.size14,
                  height: Sizes.size14,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: Sizes.size8,
                      height: Sizes.size8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          title: Text(
            'xpzm (${widget.chatId})',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: const Text('Active now'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.flag,
                color: isDarkMode(context) ? Colors.white : Colors.black,
                size: Sizes.size20,
              ),
              Gaps.h32,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                color: isDarkMode(context) ? Colors.white : Colors.black,
                size: Sizes.size20,
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView.separated(
            padding: const EdgeInsets.only(
              right: Sizes.size14,
              left: Sizes.size14,
              top: Sizes.size14,
              bottom: 120,
            ),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemCount: 20,
            separatorBuilder: (context, index) => Gaps.v10,
            itemBuilder: (context, index) {
              final bool isMine = index % 2 == 0;
              return Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment:
                    isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(
                      Sizes.size14,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isMine ? Colors.blue : Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(Sizes.size20),
                        topRight: const Radius.circular(Sizes.size20),
                        bottomLeft: Radius.circular(
                            isMine ? Sizes.size20 : Sizes.size5),
                        bottomRight: Radius.circular(
                            !isMine ? Sizes.size20 : Sizes.size5),
                      ),
                    ),
                    child: const Text(
                      'this is message!',
                      style: TextStyle(
                        fontSize: Sizes.size14,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: Container(
                color: isDarkMode(context)
                    ? Colors.grey.shade900
                    : Colors.grey.shade100,
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: Sizes.size24,
                    left: Sizes.size24,
                    top: Sizes.size12,
                    bottom: Sizes.size56,
                  ),
                  child: Row(
                    // textField -> width 없으면 Error
                    children: [
                      Expanded(
                        // child: CupertinoTextField(
                        //   placeholder: 'Send messages!',
                        // ),
                        child: TextField(
                          cursorColor: Theme.of(context).primaryColor,
                          style: const TextStyle(
                            fontSize: Sizes.size14,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Send messeges!',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                Sizes.size40,
                              ),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: isDarkMode(context)
                                ? Colors.black
                                : Colors.white,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size20,
                            ),
                          ),
                        ),
                      ),
                      Gaps.h20,
                      Container(
                        padding: const EdgeInsets.all(
                          Sizes.size10,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isDarkMode(context)
                              ? Colors.grey.shade700
                              : Colors.grey.shade300,
                          border: Border.all(
                            color: isDarkMode(context)
                                ? Colors.grey.shade500
                                : Colors.grey.shade500,
                            width: 2,
                          ),
                        ),
                        child: const FaIcon(
                          FontAwesomeIcons.paperPlane,
                          size: Sizes.size16,
                        ),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
