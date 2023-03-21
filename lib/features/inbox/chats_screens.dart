import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/widgets/chat_detail_screen.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  final List<int> _items = [];

  final Duration _duration = const Duration(milliseconds: 300);

  void _addItem() {
    if (_key.currentState != null) {
      // _key.currentState가 null이 아니기때문에 ! 붙여줄 수 있다
      _key.currentState!.insertItem(
        _items.length,
        duration: _duration,
      );
      _items.add(_items.length);
    }
  }

  void _removeItem(int index) {
    if (_key.currentState != null) {
      // _key.currentState가 null이 아니기때문에 ! 붙여줄 수 있다
      _key.currentState!.removeItem(
        index,
        (context, animiation) => SizeTransition(
          sizeFactor: animiation,
          child: Container(
            color: Colors.red,
            child: _makeTile(index),
          ),
        ),
        duration: _duration,
      );
      _items.removeAt(index);
    }
  }

  void _onChatTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ChatDetailScreen(),
      ),
    );
  }

  ListTile _makeTile(int index) {
    return ListTile(
      onLongPress: () => _removeItem(index),
      onTap: _onChatTap,
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
            onPressed: _addItem,
            icon: const FaIcon(
              FontAwesomeIcons.plus,
              size: Sizes.size20,
            ),
          )
        ],
      ),
      body: AnimatedList(
        key: _key,
        itemBuilder: (context, index, animation) {
          return FadeTransition(
            key: UniqueKey(),
            opacity: animation,
            child: SizeTransition(
              sizeFactor: animation,
              child: _makeTile(index),
            ),
          );
        },
      ),
    );
  }
}
