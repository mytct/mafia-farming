
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flame/game.dart';
import 'game/farm_game.dart';
import 'game/game_state.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => GameState(),
      child: GameWidget(
        game: FarmGame(),
        overlayBuilderMap: {
          'hud': (context, game) {
            return Consumer<GameState>(
              builder: (_, state, __) => Positioned(
                top: 30,
                right: 20,
                child: Row(
                  children: [
                    const Icon(Icons.monetization_on, color: Colors.yellow),
                    const SizedBox(width: 6),
                    Text(
                      state.coins.toString(),
                      style: const TextStyle(
                        fontSize: 20,
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
    ),
  );
}
