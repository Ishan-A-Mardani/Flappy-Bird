import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../variables/change_index.dart';

class MyBird extends StatelessWidget {
  double birdHeight;
  double birdWidth;
  final List<String> addresses;

  MyBird(
      {super.key,
      required this.birdHeight,
      required this.birdWidth,
      required this.addresses});

  final IndexController controller = Get.put(IndexController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          // color: Colors.red,
          // border: Border.fromBorderSide(BorderSide(color: Colors.black)),
          // borderRadius: BorderRadius.circular(20),
          ),
      child: Image.asset(
        addresses[controller.selectedIndex.value],
        width: birdWidth,
        height: birdHeight,
      ),
    );
  }
}
