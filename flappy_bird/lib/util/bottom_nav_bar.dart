import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBottomNavBar extends StatelessWidget {
  void Function(int)? onTabChange;

  MyBottomNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return GNav(
      onTabChange: (index) => onTabChange!(index),
      color: Colors.grey.shade500,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      activeColor: Colors.grey.shade800,
      tabBackgroundColor: Colors.grey.shade300,
      tabBorderRadius: 35,
      tabs: const [
        GButton(icon: Icons.games_rounded, text: 'Play'),
        GButton(icon: Icons.person, text: 'Avatar'),
      ],
    );
  }
}
