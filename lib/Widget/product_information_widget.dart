import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_guide/Screens/Utils/utils.dart';
import 'package:flutter_guide/Widget/cost_widget.dart';

class ProductInformationWidget extends StatelessWidget {
  final String productName;
  final double cost;
  final String sellerName;
  const ProductInformationWidget(
      {super.key,
      required this.productName,
      required this.cost,
      required this.sellerName});
      

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    SizedBox spacer = const SizedBox(height:7);
    return SizedBox(
        width: screenSize.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(productName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    letterSpacing: 0.9,
                    overflow: TextOverflow.ellipsis,
                  )),
            ),
                spacer,
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: CostWidget(color: Colors.black, cost: cost),
                )),
                spacer,
            Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "Sold  by ",style: TextStyle(color: Colors.grey[700], fontSize: 14, ),),
                    TextSpan(text: sellerName,style: const TextStyle(color: Colors.cyan, fontSize: 14, ),),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
