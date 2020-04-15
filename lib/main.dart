import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:covid19/covid19-game.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);

  SharedPreferences storage = await SharedPreferences.getInstance();

  Flame.images.loadAll(<String>[
    'bg/backyard.jpg',
    'bg/lose-splash.png',
    'branding/title.png',
    'virus/virus1.png',
    'virus/virus1-ko.png',
    'virus/virus2.png',
    'virus/virus2-ko.png',
    'virus/virus3.png',
    'virus/virus3-ko.png',
    'virus/virus4.png',
    'virus/virus4-ko.png',
    'virus/virus5.png',
    'virus/virus5-ko.png',
    'virus/virus6.png',
    'virus/virus6-ko.png',
    'virus/virus7.png',
    'virus/virus7-ko.png',
    'ui/callout.png',
    'ui/dialog-credits.png',
    'ui/dialog-help.png',
    'ui/icon-credits.png',
    'ui/icon-help.png',
    'ui/icon-music-disabled.png',
    'ui/icon-music-enabled.png',
    'ui/icon-sound-disabled.png',
    'ui/icon-sound-enabled.png',
    'ui/start-button.png',
  ]);

  Flame.audio.disableLog();
  Flame.audio.loadAll(<String>[
    'bgm/home.mp3',
    'bgm/playing.mp3',
    'sfx/haha1.ogg',
    'sfx/haha2.ogg',
    'sfx/haha3.ogg',
    'sfx/haha4.ogg',
    'sfx/haha5.ogg',
    'sfx/ouch1.ogg',
    'sfx/ouch2.ogg',
    'sfx/ouch3.ogg',
    'sfx/ouch4.ogg',
    'sfx/ouch5.ogg',
    'sfx/ouch6.ogg',
    'sfx/ouch7.ogg',
    'sfx/ouch8.ogg',
    'sfx/ouch9.ogg',
    'sfx/ouch10.ogg',
    'sfx/ouch11.ogg',
  ]);

  Covid19Game game = Covid19Game(storage);
  runApp(game.widget);

  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  flameUtil.addGestureRecognizer(tapper);
}
