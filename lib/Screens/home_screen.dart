import 'package:flutter/material.dart';
import 'package:flutter_guide/Resources/cloudFirestoreMethods.dart';
import 'package:flutter_guide/Resources/const.dart';
import 'package:flutter_guide/Widget/banner_ad_widget.dart';
import 'package:flutter_guide/Widget/categories_horizontal_list.dart';
import 'package:flutter_guide/Widget/loading_widget.dart';
import 'package:flutter_guide/Widget/product_showcase_list_view.dart';
import 'package:flutter_guide/Widget/search_bar_widget.dart';
import 'package:flutter_guide/Widget/simple_product_widget.dart';
import 'package:flutter_guide/Widget/user_details_bar.dart';

import '../Model/user_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController controller = ScrollController();
  double offset = 0;
  List<Widget>? discount70;
  List<Widget>? discount60;
  List<Widget>? discount50;
  List<Widget>? discount0;

  @override
  void initState() {
    super.initState();
    getData();
    controller.addListener(() {
      setState(() {
        offset = controller.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void getData() async {
    List<Widget> temp70 = await CloudFireStoreClass().getProductFromDiscount(70);
    List<Widget> temp60 = await CloudFireStoreClass().getProductFromDiscount(60);
    List<Widget> temp50 = await CloudFireStoreClass().getProductFromDiscount(50);
    List<Widget> temp0 = await CloudFireStoreClass().getProductFromDiscount(0);

    setState(() {
      discount70 = temp70;
      discount60 = temp60;
      discount50 = temp50;
      discount0 = temp0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(
        isReadOnly: true,
        hasBackButton: false,
      ),
      body: discount70 != null &&
              discount60 != null &&
              discount50 != null &&
              discount0 != null
          ? Stack(
              children: [
                SingleChildScrollView(
                  controller: controller,
                  child: Column(
                    children: [
                      SizedBox(
                        height: kAppBarHeight / 2,
                      ),
                      CategoriesHorizontalList(),
                      BannerAdWidget(),
                      ProductsShowCaseListView(
                          title: "Up to 70% off", children: discount70!),
                      ProductsShowCaseListView(
                          title: "Up to 60% off", children: discount60!),
                      ProductsShowCaseListView(
                          title: "Up to 50% off", children: discount50!),
                      ProductsShowCaseListView(
                          title: "Explore", children:  discount0!),
                    ],
                  ),
                ),
                UserDetailsBar(
                  offset: offset,
                ),
              ],
            )
          : LoadingWidget(),
    );
  }
}
