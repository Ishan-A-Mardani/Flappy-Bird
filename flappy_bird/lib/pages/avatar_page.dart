import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../util/image_button.dart';
import '../variables/change_index.dart';

class AvatarPage extends StatelessWidget {
  final List<String> addresses;
  final List<String> birdNames;

  AvatarPage({super.key, required this.addresses, required this.birdNames});

  final IndexController controller = Get.put(IndexController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.shade500,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "C H O O S E  A V A T A R",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 75),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageTile(
                    imageAddress: addresses[0],
                    name: birdNames[0],
                    isClicked: (0 == controller.selectedIndex.value),
                    index: 0,
                  ),
                  const SizedBox(width: 10),
                  ImageTile(
                    imageAddress: addresses[1],
                    name: birdNames[1],
                    isClicked: (1 == controller.selectedIndex.value),
                    index: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageTile(
                    imageAddress: addresses[2],
                    name: birdNames[2],
                    isClicked: (2 == controller.selectedIndex.value),
                    index: 2,
                  ),
                  const SizedBox(width: 10),
                  ImageTile(
                    imageAddress: addresses[3],
                    name: birdNames[3],
                    isClicked: (3 == controller.selectedIndex.value),
                    index: 3,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
