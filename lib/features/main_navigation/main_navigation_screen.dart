import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final screens = [
    const Center(
      child: Text('Home'),
    ),
    const Center(
      child: Text('Search'),
    ),
    const Center(
      child: Text('Search'),
    ),
    const Center(
      child: Text('Search'),
    ),
    const Center(
      child: Text('Search'),
    ),
  ];

  void _onTap(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTap,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.black38,
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house),
            label: "Home",
            tooltip: "What are your?",
            backgroundColor: Colors.amber,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
            label: "Search",
            tooltip: "What are your?",
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
            label: "Search",
            tooltip: "What are your?",
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
            label: "Search",
            tooltip: "What are your?",
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
            label: "Search",
            tooltip: "What are your?",
            backgroundColor: Colors.indigo,
          ),
        ],
      ),
    );
  }
}
