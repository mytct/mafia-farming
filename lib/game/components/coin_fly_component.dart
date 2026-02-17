import 'package:flame/components.dart';
import 'package:flame_farm_starter/utils/dimens.dart';

import 'package:flutter/foundation.dart';

class CoinFlyComponent extends SpriteComponent {
  final Vector2 target;
  final VoidCallback onArrived;

  CoinFlyComponent({
    required Sprite sprite,
    required Vector2 start,
    required this.target,
    required this.onArrived,
  }) : super(
          sprite: sprite,
          position: start,
          size: Vector2.all(Dimens.normalx),
          anchor: Anchor.center,
        );

  @override
  void update(double dt) {
    super.update(dt);

    position += (target - position) * 6 * dt;

    if (position.distanceTo(target) < 5) {
      onArrived();
      removeFromParent();
    }
  }
}
