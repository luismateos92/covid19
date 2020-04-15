import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:covid19/components/fly.dart';
import 'package:covid19/covid19-game.dart';

class Virus4Fly extends Fly {
  Virus4Fly(Covid19Game game, double x, double y) : super(game) {
    flyRect = Rect.fromLTWH(x, y, game.tileSize * 1.65, game.tileSize * 1.65);
    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite('virus/virus4.png'));
    flyingSprite.add(Sprite('virus/virus4.png'));
    deadSprite = Sprite('virus/virus4-ko.png');
  }
}
