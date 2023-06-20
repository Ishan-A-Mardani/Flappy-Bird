import 'package:get/get.dart';

class FlagController extends GetxController {
  final flag = [false, false, false].obs;
  // This makes the value observable
  // This means that when it changes, other parts of our application depending on it will be notified.
  changeValue(index, value) => flag.value[index] = value;
  bool getValue(index) => flag.value[index];
}
