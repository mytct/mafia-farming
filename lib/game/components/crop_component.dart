import 'package:flame/components.dart';
import 'package:flame_farm_starter/utils/config.dart';
import 'package:flame_farm_starter/utils/dimens.dart';

class CropComponent extends SpriteComponent {
  final List<Sprite> stages;
  int stage = 0;
  bool isReady = false;

  late final Timer _growTimer;

  CropComponent({
    required this.stages,
    required Vector2 position,
    double growthTime = 1,
  }) : super(
          sprite: stages[0],
          position: position,
          size: Vector2(Dimens.largex, Dimens.largex),
          anchor: Anchor.center,
          priority: 1,
        ) {
    _growTimer = Timer(
      growthTime,
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
    if (stage < Config.MAX_STATE_COMPONENTS) {
      stage = (stage + 1).clamp(0, stages.length - 1);
      sprite = stages[stage];
    }

    if (stage >= Config.MAX_STATE_COMPONENTS) {
      isReady = true;
      _growTimer.stop();
    }
  }
}
