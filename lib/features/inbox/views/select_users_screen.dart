import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/view_models/chat_room_vm.dart';

class SelectUsersScreen extends ConsumerStatefulWidget {
  const SelectUsersScreen({super.key});

  @override
  ConsumerState<SelectUsersScreen> createState() => _SelectUsersScreenState();
}

class _SelectUsersScreenState extends ConsumerState<SelectUsersScreen> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  _onCloseTap() {}

  ListTile _makeTile(int index) {
    print('select_users_screen - _makeTile');
    return ListTile(
      onLongPress: () {},
      onTap: () {},
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
          Text(
            '123 ($index)',
            style: const TextStyle(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Direct Messages'),
        elevation: 1,
        actions: [
          IconButton(
            onPressed: () => _onCloseTap(),
            icon: const FaIcon(
              FontAwesomeIcons.plus,
              size: Sizes.size20,
            ),
          )
        ],
      ),
    );
  }
}
