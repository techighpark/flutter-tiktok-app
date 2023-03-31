import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/onboarding/tutorial_screen.dart';
import 'package:tiktok_clone/features/onboarding/widgets/interest_button.dart';
import 'package:tiktok_clone/utils.dart';

const interests = [
  "Daily Life",
  "Comedy",
  "Entertainment",
  "Animals",
  "Food",
  "Beauty & Style",
  "Drama",
  "Learning",
  "Talent",
  "Sports",
  "Auto",
  "Family",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden",
  "Daily Life",
  "Comedy",
  "Entertainment",
  "Animals",
  "Food",
  "Beauty & Style",
  "Drama",
  "Learning",
  "Talent",
  "Sports",
  "Auto",
  "Family",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden",
];

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showTitle = false;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final showTitle = _scrollController.offset > 90;

    if (showTitle != _showTitle) {
      setState(() {
        _showTitle = showTitle;
      });
    }
  }

  void _onNextTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TutorialScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedOpacity(
          opacity: _showTitle ? 1 : 0,
          duration: const Duration(milliseconds: 1000),
          child: const Text("Choose your interests"),
        ),
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.only(
              left: Sizes.size24,
              right: Sizes.size24,
              bottom: Sizes.size48,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v1,
                const Text(
                  'Choose your Interests',
                  style: TextStyle(
                    fontSize: Sizes.size40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v20,
                const Text(
                  'Get better video recommendations',
                  style: TextStyle(
                    fontSize: Sizes.size20,
                    color: Colors.grey,
                  ),
                ),
                Gaps.v64,
                Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  children: [
                    for (String interest in interests)
                      InterestButton(interest: interest),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: isDarkMode(context) ? Colors.black : Colors.white,
        padding: const EdgeInsets.only(
          bottom: Sizes.size40,
          top: Sizes.size16,
          left: Sizes.size24,
          right: Sizes.size24,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size16,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: GestureDetector(
            onTap: _onNextTap,
            child: const Text(
              'Next',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: Sizes.size16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
