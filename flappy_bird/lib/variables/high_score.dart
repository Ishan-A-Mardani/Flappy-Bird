import 'package:get/get.dart';

class HighScoreController extends GetxController {
  final highScore = 0.obs;
  // This makes the value observable
  // This means that when it changes, other parts of our application depending on it will be notified.
  changeValue(value) => highScore.value = value;
  int getValue() => highScore.value;
}
