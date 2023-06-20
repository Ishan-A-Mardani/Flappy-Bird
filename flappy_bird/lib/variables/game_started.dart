import 'package:get/get.dart';

class GameStartedController extends GetxController {
  final gameStarted = false.obs;
  // This makes the value observable
  // This means that when it changes, other parts of our application depending on it will be notified.
  changeValue(value) => gameStarted.value = value;
  bool getValue() => gameStarted.value;
}
