import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:covid19/components/fly.dart';
import 'package:covid19/covid19-game.dart';

class Virus7Fly extends Fly {
  double get speed => game.tileSize * 2.5;

  Virus7Fly(Covid19Game game, double x, double y) : super(game) {
    flyRect = Rect.fromLTWH(x, y, game.tileSize * 2.025, game.tileSize * 2.025);
    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite('virus/virus7.png'));
    flyingSprite.add(Sprite('virus/virus7.png'));
    deadSprite = Sprite('virus/virus7-ko.png');
  }
}
