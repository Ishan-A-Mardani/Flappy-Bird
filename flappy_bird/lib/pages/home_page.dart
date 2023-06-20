import 'package:flappy_bird/variables/flag.dart';
import 'package:flappy_bird/variables/high_score.dart';
import 'package:flappy_bird/variables/score.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../util/barriers.dart';
import '../util/bird.dart';
import '../variables/barrier_X2.dart';
import '../variables/barrier_x1.dart';
import '../variables/barrier_x3.dart';
import '../variables/bird_y.dart';
import '../variables/change_index.dart';
import 'dart:async';
import 'dart:math';

import '../variables/game_started.dart';
// import 'package:flappy_bird/avatar_page.dart';

class HomePage extends StatefulWidget {
  final List<String> addresses;
  final List<String> birdNames;
  const HomePage({super.key, required this.addresses, required this.birdNames});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final IndexController controller = Get.put(IndexController());
  final BirdYController birdYController = Get.put(BirdYController());
  final BarrierX1Controller barrierX1Controller =
      Get.put(BarrierX1Controller());
  final BarrierX2Controller barrierX2Controller =
      Get.put(BarrierX2Controller());
  final BarrierX3Controller barrierX3Controller =
      Get.put(BarrierX3Controller());
  final ScoreController scoreController = Get.put(ScoreController());
  final HighScoreController highScoreController =
      Get.put(HighScoreController());
  final GameStartedController gameStartedController =
      Get.put(GameStartedController());
  final FlagController flagController = Get.put(FlagController());

  List<double> birdHeight = [50, 50, 50, 50];
  List<double> birdWidth = [50, 50, 50, 50];

  // double birdYaxis = 0.5;
  double time = 0;
  double height = 0;
  double initialHeight = 0;
  // bool gameHasStarted = false;
  // double barrierX1 = 0.8;
  // double barrierX2 = 1.3;
  // double barrierX3 = 1.8;
  double barrierSize1 = 200.0;
  double barrierSize2 = 250.0;
  double barrierSize3 = 150.0;
  // int score = 0;
  // int highScore = 0;
  double barrierWidth = 100;
  // double birdWidth = 50;
  // double birdHeight = 50;
  static int flex = 4;
  double ratio = flex / (flex + 1);
  double error = 0.02;
  // bool flag1 = true;
  // bool flag2 = true;
  // bool flag3 = true;

  bool birdIsDead() {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double gameAreaHeight = screenHeight * ratio;
    double barrierWidthRelative = barrierWidth / screenWidth;
    double birdHeightRelative =
        birdHeight[controller.selectedIndex.value] / gameAreaHeight;
    double birdWidthRelative =
        birdWidth[controller.selectedIndex.value] / screenWidth;
    double birdYaxis = birdYController.getValue();
    double barrierX1 = barrierX1Controller.getValue();
    double barrierX2 = barrierX2Controller.getValue();
    double barrierX3 = barrierX3Controller.getValue();

    if (birdYaxis == 1.0 || birdYaxis == 0.0) {
      return true;
    }
    if ((barrierX1 - 0.5 + error) <= birdWidthRelative &&
        (barrierX1 + barrierWidthRelative - error) >= 0.5) {
      if (birdYaxis - birdHeightRelative + error <=
              (400.0 - barrierSize1) / gameAreaHeight ||
          birdYaxis + birdHeightRelative >= 1 - barrierSize1 / gameAreaHeight) {
        return true;
      }
    }
    if (flagController.getValue(0) &&
        (barrierX1 + barrierWidthRelative) < 0.5) {
      scoreController.changeValue(scoreController.getValue() + 1);
      flagController.changeValue(0, false);
    }
    if ((barrierX2 - 0.5 + error) <= birdWidthRelative &&
        (barrierX2 + barrierWidthRelative - error) >= 0.5) {
      if (birdYaxis - birdHeightRelative + error <=
              (400.0 - barrierSize2) / gameAreaHeight ||
          birdYaxis + birdHeightRelative >= 1 - barrierSize2 / gameAreaHeight) {
        return true;
      }
    }
    if (flagController.getValue(1) &&
        (barrierX2 + barrierWidthRelative) < 0.5) {
      scoreController.changeValue(scoreController.getValue() + 1);
      flagController.changeValue(1, false);
    }
    if ((barrierX3 - 0.5 + error) <= birdWidthRelative &&
        (barrierX3 + barrierWidthRelative - error) >= 0.5) {
      if (birdYaxis - birdHeightRelative + error <=
              (400.0 - barrierSize3) / gameAreaHeight ||
          birdYaxis + birdHeightRelative >= 1 - barrierSize3 / gameAreaHeight) {
        return true;
      }
    }
    if (flagController.getValue(2) &&
        (barrierX3 + barrierWidthRelative) < 0.5) {
      scoreController.changeValue(scoreController.getValue() + 1);
      flagController.changeValue(2, false);
    }
    return false;
  }

  void jump() {
    time = 0;
    initialHeight = birdYController.getValue();
  }

  void startGame() {
    gameStartedController.changeValue(true);
    time = 0;
    initialHeight = birdYController.getValue();
    Timer.periodic(const Duration(milliseconds: 60), (timer) {
      time += 0.04;
      height = (-3.0 * time * time) + (1.2 * time);
      if (initialHeight - height >= 1.0) {
        birdYController.changeValue(1.0);
      } else if (initialHeight - height <= 0.0) {
        birdYController.changeValue(0.0);
      } else {
        birdYController.changeValue(initialHeight - height);
      }
      if (barrierX1Controller.getValue() <= -0.2) {
        barrierX1Controller.changeValue(barrierX1Controller.getValue() + 1.5);
        flagController.changeValue(0, true);
        barrierSize1 =
            (double.parse(Random().nextDouble().toStringAsFixed(2)) + 0.1) *
                329.0;
      } else {
        barrierX1Controller.changeValue(barrierX1Controller.getValue() - 0.025);
      }
      if (barrierX2Controller.getValue() <= -0.2) {
        barrierX2Controller.changeValue(barrierX2Controller.getValue() + 1.5);
        flagController.changeValue(1, true);
        barrierSize2 =
            (double.parse(Random().nextDouble().toStringAsFixed(2)) + 0.1) *
                329.0;
      } else {
        barrierX2Controller.changeValue(barrierX2Controller.getValue() - 0.025);
      }
      if (barrierX3Controller.getValue() <= -0.2) {
        barrierX3Controller.changeValue(barrierX3Controller.getValue() + 1.5);
        flagController.changeValue(2, true);
        barrierSize3 =
            (double.parse(Random().nextDouble().toStringAsFixed(2)) + 0.1) *
                329.0;
      } else {
        barrierX3Controller.changeValue(barrierX3Controller.getValue() - 0.025);
      }
      if (birdIsDead()) {
        // print(
        //     "birdYaxis: ${birdYaxis * MediaQuery.of(context).size.height * 2 / 5}");
        // print("barrierX1: ${barrierX1 * MediaQuery.of(context).size.width}");
        // print("barrierX2: ${barrierX2 * MediaQuery.of(context).size.width}");
        // print("barrierX3: ${barrierX3 * MediaQuery.of(context).size.width}");
        // print("barrierSize1 down: $barrierSize1");
        // print("barrierSize2 down: $barrierSize2");
        // print("barrierSize3 down: $barrierSize3");
        // print("barrierSize1 up: ${400 - barrierSize1}");
        // print("barrierSize2 up: ${400 - barrierSize2}");
        // print("barrierSize3 up: ${400 - barrierSize3}");
        // print("vgefgefg");
        timer.cancel();
        // Future.delayed(const Duration(milliseconds: 2500), () {});
        // _showDialog();
      }
    });
  }

  void resetGame() {
    // Navigator.of(context).pop();
    birdYController.changeValue(0.5);
    barrierX1Controller.changeValue(0.8);
    barrierX2Controller.changeValue(1.3);
    barrierX3Controller.changeValue(1.8);
    gameStartedController.changeValue(false);
    flagController.changeValue(0, true);
    flagController.changeValue(1, true);
    flagController.changeValue(2, true);
    setState(() {
      time = 0;
      initialHeight = 0;
      barrierSize1 = 200.0;
      barrierSize2 = 250.0;
      barrierSize3 = 150.0;
    });
    if (scoreController.getValue() > highScoreController.getValue()) {
      highScoreController.changeValue(scoreController.getValue());
    }
    scoreController.changeValue(0);
  }

  void _showDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: const Alignment(0, 0.825),
          backgroundColor: Colors.brown,
          title: const Center(
              child: Text("Game Over",
                  style: TextStyle(color: Colors.white, fontSize: 22))),
          content: Container(
              alignment: Alignment.center,
              height: 20,
              width: 30,
              child: Text("Score: ${scoreController.getValue()}",
                  style: const TextStyle(color: Colors.white, fontSize: 17))),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: resetGame,
              child: const Text("Play Again",
                  style: TextStyle(color: Colors.brown, fontSize: 17)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          if (gameStartedController.getValue() && !birdIsDead()) {
            jump();
          } else if (!gameStartedController.getValue() && !birdIsDead()) {
            startGame();
          }
          Future.delayed(const Duration(seconds: 3), () {
            if (birdIsDead()) {
              resetGame();
            }
          });
        },
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                flex: flex,
                child: Stack(
                  children: [
                    Container(
                      color: Colors.blue,
                      alignment: const Alignment(0, 0),
                      // height: MediaQuery.of(context).size.height,
                      // width: MediaQuery.of(context).size.width,
                    ),
                    AnimatedPositioned(
                      left: MediaQuery.of(context).size.width / 2,
                      top: birdYController.getValue() *
                              MediaQuery.of(context).size.height *
                              ratio -
                          birdHeight[controller.selectedIndex.value],
                      duration: const Duration(milliseconds: 0),
                      child: MyBird(
                        addresses: widget.addresses,
                        birdHeight: birdHeight[controller.selectedIndex.value],
                        birdWidth: birdWidth[controller.selectedIndex.value],
                      ),
                    ),
                    // AnimatedContainer(
                    //   alignment: Alignment(0, birdYaxis),
                    //   duration: const Duration(milliseconds: 0),
                    //   color: Colors.blue,
                    //   // child: Container(color: Colors.red, child: const MyBird()),
                    //   child: const MyBird(),
                    // ),

                    AnimatedPositioned(
                      // alignment: Alignment(barrierX1, 1.1),
                      bottom: 0,
                      left: ((barrierX1Controller.getValue()) *
                          MediaQuery.of(context).size.width),
                      duration: const Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: barrierSize1,
                      ),
                    ),

                    AnimatedPositioned(
                      // alignment: Alignment(barrierX1, -1.1),
                      top: 0,
                      left: ((barrierX1Controller.getValue()) *
                          MediaQuery.of(context).size.width),
                      duration: const Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 400.0 - barrierSize1,
                      ),
                    ),
                    AnimatedPositioned(
                      // alignment: Alignment(barrierX2, 1.1),
                      bottom: 0,
                      left: ((barrierX2Controller.getValue()) *
                          MediaQuery.of(context).size.width),
                      duration: const Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: barrierSize2,
                      ),
                    ),

                    AnimatedPositioned(
                      // alignment: Alignment(barrierX2, -1.1),
                      top: 0,
                      left: ((barrierX2Controller.getValue()) *
                          MediaQuery.of(context).size.width),
                      duration: const Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 400.0 - barrierSize2,
                      ),
                    ),

                    AnimatedPositioned(
                      // alignment: Alignment(barrierX3, 1.1),
                      bottom: 0,
                      left: ((barrierX3Controller.getValue()) *
                          MediaQuery.of(context).size.width),
                      duration: const Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: barrierSize3,
                      ),
                    ),

                    AnimatedPositioned(
                      // alignment: Alignment(barrierX3, -1.1),
                      top: 0,
                      left: ((barrierX3Controller.getValue()) *
                          MediaQuery.of(context).size.width),
                      duration: const Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 400.0 - barrierSize3,
                      ),
                    ),
                    Container(
                      alignment: const Alignment(0, -0.2),
                      child: gameStartedController.getValue() || birdIsDead()
                          ? const Text(" ")
                          : const Text("T A P  T O  P L A Y",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white)),
                    ),
                    Container(
                      alignment: const Alignment(0, 0),
                      child: !birdIsDead()
                          ? const Text(" ")
                          : Text(
                              "${widget.birdNames[controller.selectedIndex.value]}  DIED",
                              style: const TextStyle(
                                  fontSize: 30, color: Colors.white)),
                    ),
                  ],
                ),
              ),
              Container(
                height: 15,
                color: Colors.green,
              ),
              Expanded(
                child: Container(
                  color: Colors.brown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Score',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                          const SizedBox(height: 20),
                          Text('${scoreController.getValue()}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 35)),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Best Score',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                          const SizedBox(height: 20),
                          Text('${highScoreController.getValue()}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 35))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
