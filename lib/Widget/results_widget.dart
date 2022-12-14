import 'package:flutter/material.dart';
import 'package:flutter_guide/Model/product_model.dart';
import 'package:flutter_guide/Screens/Utils/utils.dart';
import 'package:flutter_guide/Screens/product_screen.dart';
import 'package:flutter_guide/Widget/cost_widget.dart';
import 'package:flutter_guide/Widget/product_information_widget.dart';
import 'package:flutter_guide/Widget/rating_star.dart';

class ResultWidget extends StatelessWidget {
  final ProductModel product;
  const ResultWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(productModel: product),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: screenSize.width / 3, child: Image.network(product.url)),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(product.productName,
                  maxLines: 3, overflow: TextOverflow.ellipsis),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: screenSize.width / 5,
                      child: FittedBox(
                          child: RatingStartWidget(rating: product.rating))),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: Text(product.noOfRating.toString(),
                        style: const TextStyle(
                          color: Colors.cyan,
                        )),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
              child: FittedBox(
                child: CostWidget(
                    color: const Color.fromARGB(255, 199, 31, 19),
                    cost: product.cost),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
