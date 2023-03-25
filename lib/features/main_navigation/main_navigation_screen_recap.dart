import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class MainNavigationScreenRecap extends StatefulWidget {
  const MainNavigationScreenRecap({super.key});

  @override
  State<MainNavigationScreenRecap> createState() =>
      _MainNavigationScreenRecapState();
}

class _MainNavigationScreenRecapState extends State<MainNavigationScreenRecap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            elevation: 1,
            title: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: Sizes.size40,
                    child: TextField(
                      style: const TextStyle(
                        fontSize: Sizes.size14,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            Sizes.size32,
                          ),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.orange[100],
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                          // vertical: Sizes.size1,
                          horizontal: Sizes.size96,
                        ),
                        prefix: const Text('prefix'),
                        prefixIcon: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            FaIcon(
                              FontAwesomeIcons.magnifyingGlass,
                              size: Sizes.size16,
                            ),
                          ],
                        ),
                        suffixIconColor: Colors.white,
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.cake,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            bottom: const TabBar(
              labelColor: Colors.red,
              indicatorColor: Colors.black,
              tabs: [
                Tab(
                  text: 'Tab',
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(
            Sizes.size12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    child: AnimatedOpacity(
                      opacity: 1,
                      duration: const Duration(
                        milliseconds: 300,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          FaIcon(
                            FontAwesomeIcons.house,
                            color: Colors.white,
                          ),
                          Gaps.v5,
                          AnimatedDefaultTextStyle(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            duration: Duration(milliseconds: 300),
                            child: Text('Home'),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
