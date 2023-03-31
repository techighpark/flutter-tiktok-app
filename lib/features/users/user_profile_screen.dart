import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/settings/settings_screen.dart';
import 'package:tiktok_clone/features/users/widgets/persistance_tab_bar.dart';
import 'package:tiktok_clone/features/users/widgets/profile_information.dart';
import 'package:tiktok_clone/features/users/widgets/profile_information_divider.dart';
import 'package:tiktok_clone/features/users/widgets/profile_post.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  void _onGearPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  title: const Text('techigh_'),
                  // backgroundColor:
                  //     isDarkMode(context) ? Colors.black : Colors.white,
                  actions: [
                    IconButton(
                      onPressed: _onGearPressed,
                      icon: const FaIcon(
                        FontAwesomeIcons.gear,
                        size: Sizes.size20,
                      ),
                    )
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: Sizes.size20,
                    ),
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          foregroundImage: NetworkImage(
                              'https://avatars.githubusercontent.com/u/75081212?v=4'),
                          child: Text('techigh_'),
                        ),
                        Gaps.v20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              '@techigh_',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: Sizes.size16,
                              ),
                            ),
                            Gaps.h5,
                            FaIcon(
                              FontAwesomeIcons.solidCircleCheck,
                              size: Sizes.size16,
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                        Gaps.v24,
                        SizedBox(
                          height: Sizes.size48,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              ProfileInformation(
                                informationCount: 97,
                                informationTitle: 'Follwing',
                              ),
                              ProfileInformationDivider(),
                              ProfileInformation(
                                informationCount: '10.1K',
                                informationTitle: 'Follwers',
                              ),
                              ProfileInformationDivider(),
                              ProfileInformation(
                                informationCount: '12.3M',
                                informationTitle: 'Likes',
                              ),
                            ],
                          ),
                        ),
                        Gaps.v40,
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: Sizes.size36,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: Sizes.size48,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(Sizes.size4)),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Follow',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Gaps.h10,
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: Sizes.size16,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey.shade500,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(
                                            Sizes.size4,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: FaIcon(
                                          FontAwesomeIcons.paperPlane,
                                          size: Sizes.size16,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ),
                                    Gaps.h4,
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: Sizes.size16,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey.shade500,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(
                                            Sizes.size4,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: FaIcon(
                                          FontAwesomeIcons.heart,
                                          size: Sizes.size16,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gaps.v14,
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Sizes.size32,
                          ),
                          child: Text(
                            'All highlights and where to watch live matches on FIFA+ I wonder how it would look!',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Gaps.v14,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            FaIcon(
                              FontAwesomeIcons.link,
                              size: Sizes.size12,
                            ),
                            Gaps.h4,
                            Text(
                              'https://nomadcoders.co',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                        Gaps.v10,
                      ],
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  delegate: PersistanceTabBar(),
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) => GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    // scroll할때 keyboard dissmiss!!
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    // padding: const EdgeInsets.all(
                    //   Sizes.size6,
                    // ),
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          constraints.maxWidth > Breakpoints.sm ? 5 : 3,
                      mainAxisSpacing: Sizes.size2,
                      crossAxisSpacing: Sizes.size2,
                      // mainAxisSpacing: size.height * 0.02,
                      // crossAxisSpacing: size.width * 0.05,
                      childAspectRatio: 9 / 12,
                    ),
                    itemCount: 40,
                    itemBuilder: (BuildContext context, int index) {
                      return const ProfilePost();
                    },
                  ),
                ),
                const Center(child: Text('2'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
