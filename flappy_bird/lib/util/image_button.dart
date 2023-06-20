import 'package:flappy_bird/variables/game_started.dart';
import 'package:flappy_bird/variables/page_index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../variables/change_index.dart';

class ImageTile extends StatefulWidget {
  final String imageAddress;
  final String name;
  bool isClicked = false;
  int index = 0;
  final IndexController controller = Get.put(IndexController());
  final PageIndexController pageIndexController =
      Get.put(PageIndexController());
  final GameStartedController gameStartedController =
      Get.put(GameStartedController());

  ImageTile({
    super.key,
    required this.imageAddress,
    required this.name,
    required this.isClicked,
    required this.index,
  });

  @override
  State<ImageTile> createState() => _ImageTileState();
}

class _ImageTileState extends State<ImageTile> {
  void onTap() {
    if (!widget.isClicked) {
      widget.controller.changeIndex(widget.index);
    }
    widget.pageIndexController.changeIndex(0);
    widget.gameStartedController.changeValue(false);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.blue.shade400,
        elevation: 10,
        borderRadius: BorderRadius.circular(25),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.isClicked
                    ? Colors.green.shade700
                    : Colors.grey.shade400,
                width: 12,
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: 125,
                  width: 155,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.imageAddress),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                // Ink.image(
                //   image: AssetImage(widget.imageAddress),
                //   // height: 125,
                //   // width: 155,
                //   fit: BoxFit.contain,
                // ),
                const SizedBox(height: 5),
                Text(
                  widget.name,
                  style: const TextStyle(color: Colors.white, fontSize: 32),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
