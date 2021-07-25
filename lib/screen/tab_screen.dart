import 'package:duolingo_copy/models/contants.dart';
import 'package:duolingo_copy/screen/tabs/division_tab.dart';
import 'package:duolingo_copy/screen/tabs/home_tab.dart';
import 'package:duolingo_copy/screen/tabs/shop_tab.dart';
import 'package:duolingo_copy/screen/tabs/statistics_tab.dart';
import 'package:duolingo_copy/screen/tabs/stories_tab.dart';
import 'package:duolingo_copy/store/screen_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final _screenStore = ScreenStore();
  final _pageController = PageController();

  _onTap(int tab) {
    if (_screenStore.selectedScreen != tab) {
      setState(() {
        _screenStore.changeScreen(tab);
        _pageController.animateToPage(tab,
            duration: Duration(microseconds: 5000),
            curve: Curves.linearToEaseOut);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => _screenStore,
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: [
              HomeTab(),
              StoriesTab(),
              StatisticsTab(),
              DivisionTab(),
              ShopTab()
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: Colors.white10, width: 0.75))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildNavItem(Icons.home, Constants.HOME_TAB),
                buildNavItem(Icons.menu_book, Constants.STORIES_TAB),
                buildNavItem(
                    Icons.person, Constants.STATISTICS_TAB),
                buildNavItem(Icons.shield, Constants.DIVISION_TAB),
                buildNavItem(Icons.language, Constants.SHOP_TAB),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildNavItem(IconData? iconData, int index) {
    return GestureDetector(
        onTap: () => _onTap(index), child: getDefaultNav(iconData!, index));
  }

  getDefaultNav(IconData iconData, int index) {
    return Container(
      width: 40.0,
      height: 40,
      child: Icon(iconData,
          color:
              index == _screenStore.selectedScreen ? Colors.white : Colors.grey,
          size: 30.0),
    );
  }
}
