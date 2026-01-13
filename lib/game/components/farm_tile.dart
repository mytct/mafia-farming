import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_farm_starter/game/farm_game.dart';
import 'package:flutter/material.dart';

import 'crop_component.dart';

class FarmTile extends RectangleComponent
    with TapCallbacks, HasGameRef<FarmGame> {
  CropComponent? crop;

  FarmTile({required Vector2 position})
      : super(
          position: position,
          size: Vector2.all(48),
          paint: Paint()..color = const Color(0xFF8BC34A),
        );

  @override
  void onTapDown(TapDownEvent event) {
    if (crop == null) {
      crop = CropComponent(
        stages: gameRef.growthSprites,
        position:
            Vector2(position.x + size.x / 2, position.y + size.y / 2 - 10),
      );
      gameRef.add(crop!);
      return;
    }

    if (crop!.isReady) {
      gameRef.spawnCoin(crop!.position);
      crop!.removeFromParent();
      crop = null;
    }
  }
}
