import 'package:get/get.dart';

class BarrierX2Controller extends GetxController {
  final barrierX2 = 1.3.obs;
  // This makes the value observable
  // This means that when it changes, other parts of our application depending on it will be notified.
  changeValue(value) => barrierX2.value = value;
  double getValue() => barrierX2.value;
}
