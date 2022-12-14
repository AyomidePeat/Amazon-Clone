import 'package:flutter_guide/Screens/cart_screen.dart';
import 'package:flutter_guide/Screens/home_screen.dart';
import 'package:flutter_guide/Screens/more_screen.dart';
import 'package:flutter_guide/Screens/sell_screen.dart';
import 'package:flutter_guide/providers/user_details_provider.dart';
import 'package:flutter_guide/Resources/cloudFirestoreMethods.dart';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenLayout extends StatefulWidget {
  const ScreenLayout({Key? key}) : super(key: key);

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  PageController pageController = PageController();
  int currentPage = 0;

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  changePage(int page) {
    pageController.jumpToPage(page);
    setState(() {
      currentPage = page;
    });
  }

  @override
  void initState() {
    super.initState();
    CloudFireStoreClass().getNameAndAddress();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<UserDetailsProvider>(context).getData();
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Scaffold(
          body: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: pageController,
            children: const [HomeScreen(), CartScreen(),SellScreen(),MoreScreen(), ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey[400]!, width: 1),
              ),
            ),
            child: TabBar(
              indicator: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.cyan, width: 4),
                ),
              ),
              onTap: changePage,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  child: Icon(
                    Icons.home_outlined,
                    color: currentPage == 0 ? Colors.cyan : Colors.black,
                  ),
                ),
                Tab(
                  child: Icon(
                    Icons.account_circle_outlined,
                    color: currentPage == 1 ? Colors.cyan : Colors.black,
                  ),
                ),
                Tab(
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    color: currentPage == 2 ? Colors.cyan : Colors.black,
                  ),
                ),
                Tab(
                  child: Icon(
                    Icons.menu,
                    color: currentPage == 3 ? Colors.cyan : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
