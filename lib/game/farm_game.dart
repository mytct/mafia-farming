
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/farm_tile.dart';
import 'components/coin_fly_component.dart';
import 'game_state.dart';
import 'package:flame/events.dart';

import 'package:flame/sprite.dart';

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
          srcSize: Vector2(64,213),
        ),
        Sprite(
          image,
          srcPosition: Vector2(64, 0),
          srcSize: Vector2(64, 213),
        ),
        Sprite(
          image,
          srcPosition: Vector2(128, 0),
          srcSize: Vector2(64, 213),
        ),
        Sprite(
          image,
          srcPosition: Vector2(256, 0),
          srcSize: Vector2(64, 213),
        ),
      ];
    coinSheet = SpriteSheet(image: coinImg, srcSize: Vector2(64, 64));

    overlays.add('hud');
    _createGrid();
  }

  void _createGrid() {
    for (int y = 0; y < 3; y++) {
      for (int x = 0; x < 4; x++) {
        add(
          FarmTile(
            position: Vector2(40 + x * 60, 200 + y * 60),
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
