import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/activity_screen.dart';
import 'package:tiktok_clone/features/inbox/chats_screens.dart';
import 'package:tiktok_clone/features/inbox/widgets/inbox_list_tile.dart';
import 'package:tiktok_clone/utils.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  void _dmPressed(BuildContext context) {
    context.pushNamed(ChatsScreen.routeName);

    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => const ChatsScreen(),
    //   ),
    // );
  }

  void _onActivityTap(BuildContext context) {
    context.pushNamed(ActivityScreen.routeName);
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => const ActivityScreen(),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('Inbox'),
        actions: [
          IconButton(
            onPressed: () => _dmPressed(context),
            icon: const FaIcon(
              FontAwesomeIcons.paperPlane,
              size: Sizes.size16,
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () => _onActivityTap(context),
            // selected: true,
            title: const Text(
              'Activity',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: const FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size14,
              color: Colors.black,
            ),
          ),
          Container(
            height: Sizes.size1,
            color: isDarkMode(context)
                ? Colors.grey.shade800
                : Colors.grey.shade200,
          ),
          const InboxListTile(
            title: 'New Followers',
            subtitle: 'Messages from followers will apperr here',
            leadingIcon: FontAwesomeIcons.users,
            trailingIcon: FontAwesomeIcons.chevronRight,
          ),
        ],
      ),
    );
  }
}
