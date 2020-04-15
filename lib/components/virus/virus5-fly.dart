import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:covid19/components/fly.dart';
import 'package:covid19/covid19-game.dart';

class Virus5Fly extends Fly {
  double get speed => game.tileSize * 2.5;

  Virus5Fly(Covid19Game game, double x, double y) : super(game) {
    flyRect = Rect.fromLTWH(x, y, game.tileSize * 2.025, game.tileSize * 2.025);
    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite('virus/virus5.png'));
    flyingSprite.add(Sprite('virus/virus5.png'));
    deadSprite = Sprite('virus/virus5-ko.png');
  }
}
