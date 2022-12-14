import 'package:flutter/material.dart';
import 'package:flutter_guide/Resources/const.dart';
import 'package:flutter_guide/Screens/Utils/utils.dart';
import 'package:flutter_guide/Screens/search_screen.dart';

class AccountScreenAppbar extends StatelessWidget with PreferredSizeWidget {
  AccountScreenAppbar({Key? key})
      : preferredSize = Size.fromHeight(kAppBarHeight),
        super(key: key);

  @override
  final Size preferredSize;
  List<Color> backgroundGradient = [Color(0xffa0e9ce), Color(0xff80d9e9)];
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Container(
        height: kAppBarHeight,
        width: screenSize.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: backgroundGradient,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Image.network(
                amazonLogoUrl,
                height: kAppBarHeight * 0.7,
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_outlined,
                      color: Colors.black,
                    )),
              ],
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const SearchScreen()));
              },
              icon: const Icon(
                Icons.search_outlined,
                color: Colors.black,
              ),
            ),
          ],
        ));
  }
}
