import 'package:flutter/material.dart';
import 'package:flutter_guide/Screens/Utils/utils.dart';

class ProductsShowCaseListView extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const ProductsShowCaseListView(
      {Key? key, required this.title, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    double height = screenSize.height / 4;
    double titleHeight = 25;
    return Container(
        
        margin: const EdgeInsets.all(8),
         padding: const EdgeInsets.all(8),
        height: height,
        width: screenSize.width,
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: titleHeight,
              child: Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                 const  Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: Text("Show more",
                        style: TextStyle(
                          color: Colors.cyan,
                        )),
                  )
                ],
              ),
           

            ), SizedBox(
              height: height -(titleHeight+26) ,
              width: screenSize.width,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children : children,
              ),
            ),
          ],
        ));
  }
}
