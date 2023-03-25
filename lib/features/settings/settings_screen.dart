import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListWheelScrollView(
        diameterRatio: 4,
        // useMagnifier: true,
        offAxisFraction: 10,
        magnification: 1.5,
        itemExtent: 200,
        children: [
          for (var x in [1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1])
            FractionallySizedBox(
              widthFactor: 1,
              child: Container(
                color: Colors.teal,
                alignment: Alignment.center,
                child: Text(
                  '$x',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 39,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
