import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class StfSceen extends StatefulWidget {
  const StfSceen({super.key});

  @override
  State<StfSceen> createState() => _StfSceenState();
}

class _StfSceenState extends State<StfSceen> {
  int _clicks = 0;

  void _increase() {
    _clicks += 1;
    setState(() {});
  }

  @override
  void dispose() {
    print(_clicks);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$_clicks",
            style: const TextStyle(
              fontSize: Sizes.size40,
            ),
          ),
          TextButton(
            onPressed: _increase,
            child: const Text('Plus'),
          )
        ],
      ),
    );
  }
}
