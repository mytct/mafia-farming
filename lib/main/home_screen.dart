// ignore_for_file: unused_element

import 'package:app_core/ui/core_stateful.dart';
import 'package:flame/game.dart';
import 'package:flame_farm_starter/game/farm_game.dart';
import 'package:flame_farm_starter/game/game_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends CoreView {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends CoreViewState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameState(),
      child: GameWidget(
        game: FarmGame(),
        overlayBuilderMap: {
          'hud': (context, game) {
            return Consumer<GameState>(
              builder: (_, state, __) => Positioned(
                top: 29,
                right: 19,
                child: Row(
                  children: [
                    const Icon(Icons.abc, color: Colors.yellow),
                    const SizedBox(width: 5),
                    Text(
                      state.coins.toString(),
                      style: const TextStyle(
                        fontSize: 19,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        },
      ),
    );
  }

  @override
  void clear() {
    // TODO: implement clear
  }

  @override
  void initData() {
    // TODO: implement initData
  }

  @override
  void requestApi() {
    // TODO: implement requestApi
  }
}
