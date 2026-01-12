import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../farm_game.dart';
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
    // 🌱 Plant
    if (crop == null) {
      crop = CropComponent(
        stages: gameRef.growthSprites,
        position: position + size / 2,
      );
      gameRef.add(crop!);
      return;
    }

    // 🌾 Harvest
    if (crop!.isReady) {
      gameRef.spawnCoin(crop!.position);
      crop!.removeFromParent();
      crop = null;
    }
  }
}
