import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'package:flame/sprite.dart';
class CropComponent extends SpriteComponent {
  final List<Sprite> stages;
  int stage = 0;
  bool isReady = false;

  late final Timer _growTimer;

  CropComponent({
    required this.stages,
    required Vector2 position,
  }) : super(
          sprite: stages[0],
          position: position,
          size: Vector2(64, 213),
          anchor: Anchor.center,
          priority: 1,
        ) {
    _growTimer = Timer(
      1.5, // ⏱ grow every 1.5 seconds
      repeat: true,
      onTick: _grow,
    );
  }

  @override
  void onMount() {
    super.onMount();
    _growTimer.start();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _growTimer.update(dt);
  }

  void _grow() {
    if (stage < 3) {
      stage = (stage + 1).clamp(0, stages.length - 1);
      sprite = stages[stage];
    }

    if (stage >= 3) {
      isReady = true;
      _growTimer.stop();
    }
  }
}
