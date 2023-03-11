import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/main_navigation/stf_screen.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/nav_tab.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  void _onTap(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const StfSceen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const StfSceen(),
          ),
          Offstage(
            offstage: _selectedIndex != 2,
            child: Container(
              child: const Text('123'),
            ),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const StfSceen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const StfSceen(),
          )
        ],
      ),
      // body: screens[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              NavTab(
                text: 'Home',
                isSelected: _selectedIndex == 0,
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.house,
                onTap: () => _onTap(0),
              ),
              NavTab(
                text: 'Discover',
                isSelected: _selectedIndex == 1,
                icon: FontAwesomeIcons.compass,
                selectedIcon: FontAwesomeIcons.solidCompass,
                onTap: () => _onTap(1),
              ),
              Gaps.h24,
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    right: 24,
                    child: Container(
                      height: 35,
                      width: 25,
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.size8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xff61D4F0),
                        borderRadius: BorderRadius.circular(Sizes.size8),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 24,
                    child: Container(
                      height: 35,
                      width: 25,
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.size8,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(Sizes.size8),
                      ),
                    ),
                  ),
                  Container(
                    height: 35,
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        Sizes.size6,
                      ),
                    ),
                    child: const Center(
                      child: FaIcon(
                        FontAwesomeIcons.plus,
                        color: Colors.black,
                        size: Sizes.size20,
                      ),
                    ),
                  )
                ],
              ),
              Gaps.h24,
              NavTab(
                text: 'Inbox',
                isSelected: _selectedIndex == 3,
                icon: FontAwesomeIcons.message,
                selectedIcon: FontAwesomeIcons.solidMessage,
                onTap: () => _onTap(3),
              ),
              NavTab(
                text: 'Profile',
                isSelected: _selectedIndex == 4,
                icon: FontAwesomeIcons.user,
                selectedIcon: FontAwesomeIcons.solidUser,
                onTap: () => _onTap(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
