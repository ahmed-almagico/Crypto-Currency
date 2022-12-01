
import 'package:flutter/material.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

import '../../core/nav_switch.dart';
import '../../core/theme.dart';
import '../../models/language_constant.dart';
import '../design/home.dart';

class Nav extends StatefulWidget {
  const Nav({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Nav> {
  late PageController _pageController;
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
  }

  void onButtonPressed(int index) {
    setState(() {
      selectedIndex = index;
    });
    _pageController.animateToPage(selectedIndex,
        duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: SlidingClippedNavBar(

        backgroundColor: Themes.isDarkMode(context) ? Colors.black :Color.fromRGBO(235,239,242,1),

    onButtonPressed: onButtonPressed,
    iconSize: 30,
    activeColor:  Colors.green,
    selectedIndex: selectedIndex,
    barItems: <BarItem>[
    BarItem(
    icon: Icons.home,
    title: translation(context).home,
    ),
    BarItem(
    icon: Icons.search_rounded,
    title: translation(context).search,
    ),
    BarItem(
    icon: Icons.person,
    title: translation(context).profile,
    ),
    ],
    ),
      body: PageView(
        controller: _pageController ,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          screens[selectedIndex]
        ],
      ),
    );
  }
}
