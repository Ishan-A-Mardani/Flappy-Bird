import 'package:get/get.dart';

class PageIndexController extends GetxController {
  final pageIndex = 0.obs;
  // This makes the value observable
  // This means that when it changes, other parts of our application depending on it will be notified.
  changeIndex(index) => pageIndex.value = index;
}
