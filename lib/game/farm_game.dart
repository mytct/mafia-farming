import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame_farm_starter/utils/config.dart';
import 'package:flame_farm_starter/utils/dimens.dart';
import 'package:flame_farm_starter/utils/game_colors.dart';
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
  Color backgroundColor() => GameColors.farmTilePlanted;

  @override
  Future<void> onLoad() async {
    final image = await images.load('sprites/plants.png');
    final coinImg = await images.load('sprites/coins.png');
    final srcSize = Vector2(Dimens.largex, Dimens.largex);

    growthSprites = [
      Sprite(
        image,
        srcPosition: Vector2(0, 0),
        srcSize: srcSize,
      ),
      Sprite(
        image,
        srcPosition: Vector2(54, 0),
        srcSize: srcSize,
      ),
      Sprite(
        image,
        srcPosition: Vector2(108, 0),
        srcSize: srcSize,
      ),
      Sprite(
        image,
        srcPosition: Vector2(162, 0),
        srcSize: srcSize,
      ),
    ];
    coinSheet = SpriteSheet(
        image: coinImg, srcSize: Vector2(Dimens.normalx, Dimens.normalx));

    overlays.add('hud');
    _createGrid();
  }

  void _createGrid() {
    for (int y = 0; y < Config.MAX_ROWS; y++) {
      for (int x = 0; x < Config.MAX_COLUMNS; x++) {
        add(
          FarmTile(
            position: Vector2(Dimens.normal + x * Config.BOUNDS_TILE,
                100 + y * Config.BOUNDS_TILE),
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
        target: Vector2(size.x - Dimens.normalx, Dimens.normalx),
        onArrived: () => state.addCoins(5),
      ),
    );
  }
}
