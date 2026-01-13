import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame_farm_starter/game/config/global_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/farm_tile.dart';
import 'components/coin_fly_component.dart';
import 'game_state.dart';
import 'package:flame/events.dart';

class FarmGame extends FlameGame with TapCallbacks {
  late SpriteSheet coinSheet;
  late List<Sprite> growthSprites;
  @override
  Color backgroundColor() => const Color(0xFF7EC850);

  @override
  Future<void> onLoad() async {
    final image = await images.load('sprites/plants.png');
    final coinImg = await images.load('sprites/coins.png');

    growthSprites = [
      Sprite(
        image,
        srcPosition: Vector2(0, 0),
        srcSize: Vector2(54, 64),
      ),
      Sprite(
        image,
        srcPosition: Vector2(54, 0),
        srcSize: Vector2(54, 64),
      ),
      Sprite(
        image,
        srcPosition: Vector2(108, 0),
        srcSize: Vector2(54, 64),
      ),
      Sprite(
        image,
        srcPosition: Vector2(162, 0),
        srcSize: Vector2(54, 64),
      ),
    ];
    coinSheet = SpriteSheet(image: coinImg, srcSize: Vector2(64, 64));

    overlays.add('hud');
    _createGrid();
  }

  void _createGrid() {
    for (int y = 0; y < MAX_ROWS; y++) {
      for (int x = 0; x < MAX_COLS; x++) {
        add(
          FarmTile(
            position: Vector2(40 + x * BOUNDS_TILE, 100 + y * BOUNDS_TILE),
          ),
        );
      }
    }
  }

  void spawnCoin(Vector2 from) {
    final state = Provider.of<GameState>(
      buildContext!,
      listen: false,
    );

    add(
      CoinFlyComponent(
        sprite: coinSheet.getSprite(0, 0),
        start: from,
        target: Vector2(size.x - 40, 40),
        onArrived: () => state.addCoins(5),
      ),
    );
  }
}
