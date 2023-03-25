import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/discover/widgets/discover_post.dart';

final tabs = [
  'Top',
  'Users',
  'Videos',
  'Sounds',
  'LIVE',
  'Shopping',
  'Brands',
];

class DsicoverScreen extends StatefulWidget {
  const DsicoverScreen({super.key});

  @override
  State<DsicoverScreen> createState() => _DsicoverScreenState();
}

class _DsicoverScreenState extends State<DsicoverScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  bool _isWriting = false;

  void _onSearchChanged(String value) {
    _isWriting = _textEditingController.text.isNotEmpty;
    setState(() {});

    print(_isWriting);
  }

  void _onSearchSubmitted(String value) {
    print(value);
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSearchClearTap() {
    _textEditingController.clear();
    _isWriting = false;
    setState(() {});
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // TabBar 사용하려면 DefaultTabController 필요
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: DefaultTabController(
        length: tabs.length,
        // scaffold - 기본적으로 body를 resize!!!!
        // keyboard 올라올때 body size
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 1,
            title: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: Sizes.size40,
                    child: TextField(
                      controller: _textEditingController,
                      onChanged: _onSearchChanged,
                      onSubmitted: _onSearchSubmitted,
                      style: const TextStyle(
                        fontSize: Sizes.size16,
                      ),
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            Sizes.size40,
                          ),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        // enabledBorder: const OutlineInputBorder(
                        // borderSide: BorderSide(color: Colors.blue, width: 2),
                        // ),
                        // focusedBorder: const OutlineInputBorder(
                        // borderSide: BorderSide(color: Colors.red),
                        // ),
                        // [Q]
                        // contentPadding: const EdgeInsets.symmetric(
                        //   horizontal: Sizes.size40,
                        // ),
                        contentPadding: const EdgeInsets.all(Sizes.size10),
                        prefixIconColor: Colors.grey.shade500,
                        hintText: 'Search',
                        hintStyle: const TextStyle(
                          fontSize: Sizes.size12,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                            left: Sizes.size16,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              FaIcon(
                                FontAwesomeIcons.magnifyingGlass,
                                size: Sizes.size16,
                              ),
                            ],
                          ),
                        ),
                        suffixIcon: _isWriting
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: _onSearchClearTap,
                                    splashColor: Colors.transparent,
                                    icon: FaIcon(
                                      FontAwesomeIcons.solidCircleXmark,
                                      color: Colors.grey.shade600,
                                      size: Sizes.size16,
                                    ),
                                  ),
                                ],
                              )
                            : null,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // input text field
            // cursor color cannot be changed in here but you can change in main.dart!!
            // title: CupertinoSearchTextField(
            //   controller: _textEditingController,
            //   placeholder: 'WTF',
            //   onChanged: _onSearchChanged,
            //   onSubmitted: _onSearchSubmitted,
            // ),
            // bottom has PreffredSizeWidget!!!! -> Container같은 widget 사용 못한다
            // 특정한 크기를 가지려고 하지만 자식 요소의 크기를 제한하지 않는 widget = 자식 요소가 부모요소의 사이즈 제한을 받지 않음
            bottom: TabBar(
              // indicator: const UnderlineTabIndicator(
              //   borderSide: BorderSide(width: 1.0),
              //   insets: EdgeInsets.symmetric(
              //     horizontal: 16.0,
              //   ),
              // ),

              splashFactory: NoSplash.splashFactory,
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size16,
              ),
              labelPadding: const EdgeInsets.symmetric(
                horizontal: Sizes.size16,
              ),
              isScrollable: true,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey.shade500,
              indicatorColor: Theme.of(context).primaryColor,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
              tabs: [
                for (var tab in tabs)
                  Tab(
                    text: tab,
                  ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // children이 있는 GridView를 만들 수 있지만, 성능이 좋지 않다.
              // 항상 builder를 사용하는게 좋다. (like PageView)
              GridView.builder(
                // scroll할때 keyboard dissmiss!!
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size6,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: Sizes.size10,
                  crossAxisSpacing: Sizes.size10,
                  // crossAxisSpacing: Sizes.size1,
                  // mainAxisSpacing: size.height * 0.02,
                  // crossAxisSpacing: size.width * 0.05,
                  childAspectRatio: 9 / 20,
                ),
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return const DiscoverPost();
                },
              ),
              for (var tab in tabs.skip(1))
                Center(
                  child: Text(
                    tab,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
