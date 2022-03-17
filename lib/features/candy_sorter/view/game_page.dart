import 'dart:async';

import 'package:candy_sorter/features/candy_sorter/model/model.dart';
import 'package:candy_sorter/features/candy_sorter/view/bowl_area.dart';
import 'package:candy_sorter/features/candy_sorter/view/candy_area.dart';
import 'package:candy_sorter/features/candy_sorter/view/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late Game game;
  late Timer _timer;

  SharedPreferences? prefs;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _createGame();
  }

  void _createGame() {
    game = Game(
      colors: [
        Colors.red,
        Colors.green,
        Colors.blueGrey,
        Colors.cyan,
        Colors.orange,
      ].sublist(0, prefs?.getInt('noOfColors') ?? 5),
      numberOfCandies: prefs?.getInt('noOfCandies') ?? 100,
      gameArea: Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height / 2,
      ),
    );
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => setState(() {}));
  }

  /// Call this when you put a candy into the bowl.
  void _onRemoveCandy(Candy candy) {
    setState(() {
      game.removeCandy(candy);
      if (game.candies.isEmpty) {
        _timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initPrefs(),
      builder: (context, snapshot) =>
          snapshot.hasData ? _loadedScaffold() : _loadingScaffold(),
    );
  }

  Widget _loadedScaffold() => Scaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _createGame,
                  child: const Text('New Game'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ),
                  ),
                  child: const Text("Settings"),
                )
              ],
            ),
            Text(
              "Time elapsed: ${game.stopwatch.elapsed.toString().split('.')[0]}",
              style: Theme.of(context).textTheme.headline5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Candies left: ${game.candies.length}',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  'Candies sorted: ${game.numberOfCandies - game.candies.length}',
                  style: Theme.of(context).textTheme.headline6,
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: CandyArea(
                game: game,
              ),
            ),
            Expanded(
              child: BowlArea(game: game, onRemoveCandy: _onRemoveCandy),
            ),
          ],
        ),
      );

  Widget _loadingScaffold() => const Scaffold(
        body: CircularProgressIndicator(),
      );

  _initPrefs() async {
    prefs ??= await SharedPreferences.getInstance();
    return prefs;
  }
}
