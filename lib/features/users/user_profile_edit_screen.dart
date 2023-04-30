import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/users/repos/user_repo.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';

class UserProfileEditScreen extends ConsumerStatefulWidget {
  const UserProfileEditScreen({
    super.key,
  });

  @override
  ConsumerState<UserProfileEditScreen> createState() =>
      _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileEditScreen> {
  final TextEditingController _bioController = TextEditingController();
  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _bioController.addListener(() {});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ref.watch(usersProvider).when(
          data: (data) => Scaffold(
            appBar: AppBar(
              title: const Text('edit'),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size36,
              ),
              child: Center(
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gaps.v36,
                        const Text(
                          'Edit your profile',
                          style: TextStyle(
                            fontSize: Sizes.size24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Gaps.v8,
                        Text(
                          'Make up your profile.',
                          style: TextStyle(
                            fontSize: Sizes.size14,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                        Gaps.v16,
                        TextField(
                          controller: _bioController,
                          decoration: InputDecoration(
                            hintText: 'Bio',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ),
                          cursorColor: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              error.toString(),
            ),
          ),
        );
  }
}
