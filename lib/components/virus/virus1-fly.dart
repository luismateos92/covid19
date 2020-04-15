import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:covid19/components/fly.dart';
import 'package:covid19/covid19-game.dart';

class Virus6Fly extends Fly {
  double get speed => game.tileSize * 5;

  Virus6Fly(Covid19Game game, double x, double y) : super(game) {
    flyRect = Rect.fromLTWH(x, y, game.tileSize * 1.5, game.tileSize * 1.5);
    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite('virus/virus6.png'));
    flyingSprite.add(Sprite('virus/virus6.png'));
    deadSprite = Sprite('virus/virus6-ko.png');
  }
}
