import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _noOfCandies = 100;
  int _noOfColors = 5;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text('Number of candies: $_noOfCandies'),
              Slider(
                min: 1,
                max: 100,
                divisions: 99,
                value: _noOfCandies.toDouble(),
                onChanged: (value) => setState(
                  () => _noOfCandies = value.toInt(),
                ),
              ),
              Text('Number of colors: $_noOfColors'),
              Slider(
                min: 1,
                max: 5,
                divisions: 4,
                value: _noOfColors.toDouble(),
                onChanged: (value) => setState(
                  () => _noOfColors = value.toInt(),
                ),
              ),
              ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Back to game')),
            ],
          ),
        ),
      ),
    );
  }
}
