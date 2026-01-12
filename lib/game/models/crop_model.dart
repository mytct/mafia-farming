

import 'package:flutter/foundation.dart';
import 'package:flame/events.dart';
import 'package:flame/sprite.dart';

enum CropStage { seed, growing, mature }

class CropModel {
  final int growSeconds;
  final DateTime plantedAt;

  CropModel({
    required this.growSeconds,
  }) : plantedAt = DateTime.now();

  CropStage get stage {
    final elapsed = DateTime.now().difference(plantedAt).inSeconds;
    if (elapsed < growSeconds * 0.3) return CropStage.seed;
    if (elapsed < growSeconds) return CropStage.growing;
    return CropStage.mature;
  }

  bool get isReady => stage == CropStage.mature;
}
