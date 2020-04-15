import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:covid19/covid19-game.dart';

class Backyard {
  final Covid19Game game;
  Sprite bgSprite;
  Rect bgRect;

  Backyard(this.game) {
    bgSprite = Sprite('bg/backyard.jpg');
    bgRect = Rect.fromLTWH(
      0,
      game.screenSize.height - (game.tileSize * 23),
      game.tileSize * 9,
      game.tileSize * 23,
    );
  }

  void render(Canvas c) {
    bgSprite.renderRect(c, bgRect);
  }

  void update(double t) {}
}
