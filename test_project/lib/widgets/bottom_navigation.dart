import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class CurvedBottomNavigationWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabTapped;

  CurvedBottomNavigationWidget(
      {required this.selectedIndex, required this.onTabTapped});

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.red.withOpacity(0.3),
      color: Colors.white,
      buttonBackgroundColor: Colors.red.shade600,
      height: 50.0,
      index: selectedIndex,
      onTap: onTabTapped,
      items: <Widget>[
        Icon(Icons.youtube_searched_for, size: 30),
        Icon(Icons.search, size: 30),
        Icon(Icons.home, size: 30),
        Icon(Icons.shopping_cart, size: 30),
        Icon(Icons.person, size: 30),
      ],
    );
  }
}
