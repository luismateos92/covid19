import 'dart:math';
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:covid19/components/backyard.dart';
import 'package:covid19/components/credits-button.dart';
import 'package:covid19/components/fly.dart';
import 'package:covid19/components/help-button.dart';
import 'package:covid19/components/highscore-display.dart';
import 'package:covid19/components/music-button.dart';
import 'package:covid19/components/score-display.dart';
import 'package:covid19/components/sound-button.dart';
import 'package:covid19/components/start-button.dart';
import 'package:covid19/components/virus/virus1-fly.dart';
import 'package:covid19/components/virus/virus2-fly.dart';
import 'package:covid19/components/virus/virus3-fly.dart';
import 'package:covid19/components/virus/virus4-fly.dart';
import 'package:covid19/components/virus/virus5-fly.dart';
import 'package:covid19/components/virus/virus6-fly.dart';
import 'package:covid19/components/virus/virus7-fly.dart';
import 'package:covid19/controllers/spawner.dart';
import 'package:covid19/view.dart';
import 'package:covid19/views/credits-view.dart';
import 'package:covid19/views/help-view.dart';
import 'package:covid19/views/home-view.dart';
import 'package:covid19/views/lost-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Covid19Game extends Game {
  final SharedPreferences storage;
  Size screenSize;
  double tileSize;
  Random rnd;

  Backyard background;
  List<Fly> flies;
  StartButton startButton;
  HelpButton helpButton;
  CreditsButton creditsButton;
  MusicButton musicButton;
  SoundButton soundButton;
  ScoreDisplay scoreDisplay;
  HighscoreDisplay highscoreDisplay;

  FlySpawner spawner;

  View activeView = View.home;
  HomeView homeView;
  LostView lostView;
  HelpView helpView;
  CreditsView creditsView;

  int score;

  AudioPlayer homeBGM;
  AudioPlayer playingBGM;

  Covid19Game(this.storage) {
    initialize();
  }

  void initialize() async {
    rnd = Random();
    flies = List<Fly>();
    score = 0;
    resize(await Flame.util.initialDimensions());

    background = Backyard(this);
    startButton = StartButton(this);
    helpButton = HelpButton(this);
    creditsButton = CreditsButton(this);
    musicButton = MusicButton(this);
    soundButton = SoundButton(this);
    scoreDisplay = ScoreDisplay(this);
    highscoreDisplay = HighscoreDisplay(this);

    spawner = FlySpawner(this);
    homeView = HomeView(this);
    lostView = LostView(this);
    helpView = HelpView(this);
    creditsView = CreditsView(this);

    homeBGM = await Flame.audio.loop('bgm/home.mp3', volume: .25);
    homeBGM.pause();
    playingBGM = await Flame.audio.loop('bgm/playing.mp3', volume: .25);
    playingBGM.pause();

    playHomeBGM();
  }

  void spawnFly() {
    double x = rnd.nextDouble() * (screenSize.width - (tileSize * 2.025));
    double y = rnd.nextDouble() * (screenSize.height - (tileSize * 2.025));

    switch (rnd.nextInt(7)) {
      case 0:
        flies.add(Virus1Fly(this, x, y));
        break;
      case 1:
        flies.add(Virus2Fly(this, x, y));
        break;
      case 2:
        flies.add(Virus3Fly(this, x, y));
        break;
      case 3:
        flies.add(Virus4Fly(this, x, y));
        break;
      case 4:
        flies.add(Virus5Fly(this, x, y));
        break;
      case 5:
        flies.add(Virus6Fly(this, x, y));
        break;
      case 6:
        flies.add(Virus7Fly(this, x, y));
        break;
    }
  }

  void playHomeBGM() {
    playingBGM.pause();
    playingBGM.seek(Duration.zero);
    homeBGM.resume();
  }

  void playPlayingBGM() {
    homeBGM.pause();
    homeBGM.seek(Duration.zero);
    playingBGM.resume();
  }

  void render(Canvas canvas) {
    background.render(canvas);

    highscoreDisplay.render(canvas);
    if (activeView == View.playing || activeView == View.lost) scoreDisplay.render(canvas);

    flies.forEach((Fly fly) => fly.render(canvas));

    if (activeView == View.home) homeView.render(canvas);
    if (activeView == View.lost) lostView.render(canvas);
    if (activeView == View.home || activeView == View.lost) {
      startButton.render(canvas);
      helpButton.render(canvas);
      creditsButton.render(canvas);
    }
    musicButton.render(canvas);
    soundButton.render(canvas);
    if (activeView == View.help) helpView.render(canvas);
    if (activeView == View.credits) creditsView.render(canvas);
  }

  void update(double t) {
    spawner.update(t);
    flies.forEach((Fly fly) => fly.update(t));
    flies.removeWhere((Fly fly) => fly.isOffScreen);
    if (activeView == View.playing) scoreDisplay.update(t);
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }

  void onTapDown(TapDownDetails d) {
    bool isHandled = false;

    // dialog boxes
    if (!isHandled) {
      if (activeView == View.help || activeView == View.credits) {
        activeView = View.home;
        isHandled = true;
      }
    }

    // music button
    if (!isHandled && musicButton.rect.contains(d.globalPosition)) {
      musicButton.onTapDown();
      isHandled = true;
    }

    // sound button
    if (!isHandled && soundButton.rect.contains(d.globalPosition)) {
      soundButton.onTapDown();
      isHandled = true;
    }

    // help button
    if (!isHandled && helpButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        helpButton.onTapDown();
        isHandled = true;
      }
    }

    // credits button
    if (!isHandled && creditsButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        creditsButton.onTapDown();
        isHandled = true;
      }
    }

    // start button
    if (!isHandled && startButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        startButton.onTapDown();
        isHandled = true;
      }
    }

    // flies
    if (!isHandled) {
      bool didHitAFly = false;
      flies.forEach((Fly fly) {
        if (fly.flyRect.contains(d.globalPosition)) {
          fly.onTapDown();
          isHandled = true;
          didHitAFly = true;
        }
      });
      if (activeView == View.playing && !didHitAFly) {
        if (soundButton.isEnabled) {
          Flame.audio.play('sfx/haha' + (rnd.nextInt(5) + 1).toString() + '.ogg');
        }
        playHomeBGM();
        activeView = View.lost;
      }
    }
  }
}
