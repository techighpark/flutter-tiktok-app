import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  void _newChat() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Direct Messages'),
        elevation: 1,
        actions: [
          IconButton(
            onPressed: _newChat,
            icon: const FaIcon(
              FontAwesomeIcons.plus,
              size: Sizes.size20,
            ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.deepOrange,
              radius: Sizes.size28,
              foregroundImage: NetworkImage(
                'https://avatars.githubusercontent.com/u/75081212?v=4',
              ),
              child: Text('xpzm'),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  '123',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '2:16 PM',
                  style: TextStyle(
                    fontSize: Sizes.size12,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
            subtitle: const Text(
              'Say hi to AntonioBM🤣',
            ),
          )
        ],
      ),
    );
  }
}
