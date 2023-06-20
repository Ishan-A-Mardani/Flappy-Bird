import 'package:get/get.dart';

class BarrierX3Controller extends GetxController {
  final barrierX3 = 1.8.obs;
  // This makes the value observable
  // This means that when it changes, other parts of our application depending on it will be notified.
  changeValue(value) => barrierX3.value = value;
  double getValue() => barrierX3.value;
}
