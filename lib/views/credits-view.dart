import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:covid19/covid19-game.dart';

class CreditsView {
  final Covid19Game game;
  Rect rect;
  Sprite sprite;

  CreditsView(this.game) {
    rect = Rect.fromLTWH(
      game.tileSize * .5,
      (game.screenSize.height / 2) - (game.tileSize * 6),
      game.tileSize * 8,
      game.tileSize * 12,
    );
    sprite = Sprite('ui/dialog-credits.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }
}
