import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../util/bottom_nav_bar.dart';
import '../variables/page_index.dart';
import 'home_page.dart';
import 'avatar_page.dart';

class NavPage extends StatefulWidget {
  final List<String> addresses = [
    'lib/images/flappy_bird_1_cropped.png',
    'lib/images/flappy_bird_2.png',
    'lib/images/flappy_bird_5.png',
    'lib/images/flappy_bird_6.png',
  ];
  final List<String> birdNames = [
    'FLAPPY',
    'HELMET',
    'FLUFFY',
    'MACHO',
  ];

  NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  final PageIndexController controller = Get.put(PageIndexController());

  void navigateBottomBar(index) {
    controller.changeIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        bottomNavigationBar: MyBottomNavBar(
          onTabChange: (index) => navigateBottomBar(index),
        ),
        body: controller.pageIndex.value == 1
            ? AvatarPage(
                addresses: widget.addresses, birdNames: widget.birdNames)
            : HomePage(
                addresses: widget.addresses, birdNames: widget.birdNames),
      ),
    );
  }
}
