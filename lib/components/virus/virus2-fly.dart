import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:covid19/components/fly.dart';
import 'package:covid19/covid19-game.dart';

class Virus2Fly extends Fly {
  double get speed => game.tileSize * 1.5;

  Virus2Fly(Covid19Game game, double x, double y) : super(game) {
    flyRect = Rect.fromLTWH(x, y, game.tileSize * 1.5, game.tileSize * 1.5);
    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite('virus/virus2.png'));
    flyingSprite.add(Sprite('virus/virus2.png'));
    deadSprite = Sprite('virus/virus2-ko.png');
  }
}
