import 'package:get/get.dart';

class BarrierX1Controller extends GetxController {
  final barrierX1 = 0.8.obs;
  // This makes the value observable
  // This means that when it changes, other parts of our application depending on it will be notified.
  changeValue(value) => barrierX1.value = value;
  double getValue() => barrierX1.value;
}
