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
  final TextEditingController _textEditingController =
      TextEditingController(text: 'Initial text');

  void _onSearchChanged(String value) {
    print(value);
  }

  void _onSearchSubmitted(String value) {
    print(value);
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
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
                      style: const TextStyle(
                        fontSize: Sizes.size14,
                      ),
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                        prefixIcon: const FaIcon(
                          FontAwesomeIcons.magnifyingGlass,
                          size: Sizes.size20,
                        ),
                        prefixIconColor: Colors.grey.shade500,
                        hintText: 'Search',
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
                // padding: const EdgeInsets.all(
                //   Sizes.size6,
                // ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: Sizes.size10,
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
