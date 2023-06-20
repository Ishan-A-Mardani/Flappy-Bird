import 'package:get/get.dart';

class ScoreController extends GetxController {
  final score = 0.obs;
  // This makes the value observable
  // This means that when it changes, other parts of our application depending on it will be notified.
  changeValue(value) => score.value = value;
  int getValue() => score.value;
}
