import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/inbox/view_models/messages_vm.dart';
import 'package:tiktok_clone/utils.dart';

class ChatDetailScreen extends ConsumerStatefulWidget {
  static const String routeName = "chatDetail";

  // 자식 경로는 /로 시작할 수 없다.
  static const String routeUrl = ":chatId";
  final String chatId;

  const ChatDetailScreen({
    super.key,
    required this.chatId,
  });

  @override
  ConsumerState<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends ConsumerState<ChatDetailScreen> {
  final TextEditingController _editingController = TextEditingController();

  void _onSendPress() {
    final text = _editingController.text;
    if (text == "") {
      return;
    } else {
      ref.read(messageProvider.notifier).sendMessage(text);
      _editingController.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(messageProvider).isLoading;
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
          /// TODO: [StreamProvider]
          ref.watch(chatProvider).when(
                data: (data) {
                  return ListView.separated(
                    reverse: true,
                    padding: EdgeInsets.only(
                      right: Sizes.size14,
                      left: Sizes.size14,
                      top: Sizes.size14,
                      bottom:
                          MediaQuery.of(context).padding.bottom + Sizes.size96,
                    ),
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    itemCount: data.length,
                    separatorBuilder: (context, index) => Gaps.v10,
                    itemBuilder: (context, index) {
                      final message = data[index];
                      final bool isMine =
                          message.userId == ref.watch(authRepo).user!.uid;
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: isMine
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(
                              Sizes.size14,
                            ),
                            decoration: BoxDecoration(
                              color: isMine
                                  ? Colors.blue
                                  : Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(Sizes.size20),
                                topRight: const Radius.circular(Sizes.size20),
                                bottomLeft: Radius.circular(
                                    isMine ? Sizes.size20 : Sizes.size5),
                                bottomRight: Radius.circular(
                                    !isMine ? Sizes.size20 : Sizes.size5),
                              ),
                            ),
                            child: Text(
                              message.text,
                              style: const TextStyle(
                                fontSize: Sizes.size14,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                error: (err, stackTrace) => Center(child: Text(err.toString())),
                loading: () => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
          Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: Container(
                color: isDarkMode(context)
                    ? Colors.grey.shade900
                    : Colors.grey.shade100,
                child: Padding(
                  padding: EdgeInsets.only(
                    right: Sizes.size24,
                    left: Sizes.size24,
                    top: Sizes.size16,
                    bottom: MediaQuery.of(context).padding.bottom,
                  ),
                  child: Row(
                    // textField -> width 없으면 Error
                    children: [
                      Expanded(
                        // child: CupertinoTextField(
                        //   placeholder: 'Send messages!',
                        // ),
                        child: TextField(
                          controller: _editingController,
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
                      IconButton(
                        onPressed: isLoading ? null : _onSendPress,
                        icon: FaIcon(
                          isLoading
                              ? FontAwesomeIcons.hourglass
                              : FontAwesomeIcons.paperPlane,
                          size: Sizes.size20,
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
