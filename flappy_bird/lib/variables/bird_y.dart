import 'package:get/get.dart';

class BirdYController extends GetxController {
  final birdY = 0.5.obs;
  // This makes the value observable
  // This means that when it changes, other parts of our application depending on it will be notified.
  changeValue(value) => birdY.value = value;
  double getValue() => birdY.value;
}
