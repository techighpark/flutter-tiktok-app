import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.size10,
          leading: Stack(
            // alignment: AlignmentDirectional.bottomEnd,
            children: [
              const Padding(
                padding: EdgeInsets.all(3.0),
                child: CircleAvatar(
                  radius: Sizes.size24,
                  child: Text('tech'),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: Sizes.size20,
                  height: Sizes.size20,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: Sizes.size12,
                      height: Sizes.size12,
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
          title: const Text(
            'xpzm',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: const Text('Active now'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              FaIcon(
                FontAwesomeIcons.flag,
                color: Colors.black,
                size: Sizes.size20,
              ),
              Gaps.h32,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                color: Colors.black,
                size: Sizes.size20,
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size14,
              vertical: Sizes.size20,
            ),
            itemCount: 10,
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
              child: BottomAppBar(
                color: Colors.grey.shade100,
                child: Row(
                  // textField -> width 없으면 Error
                  children: [
                    const Expanded(
                      child: TextField(),
                    ),
                    Gaps.h20,
                    Container(
                      child: const FaIcon(
                        FontAwesomeIcons.paperPlane,
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
