import 'package:flutter/material.dart';
import 'package:flutter_guide/Model/product_model.dart';
import 'package:flutter_guide/Resources/cloudFirestoreMethods.dart';
import 'package:flutter_guide/Screens/Utils/utils.dart';
import 'package:flutter_guide/Screens/product_screen.dart';
import 'package:flutter_guide/Widget/custom_simple_rounded.dart';
import 'package:flutter_guide/Widget/product_information_widget.dart';
import 'package:flutter_guide/Widget/square_button.dart';

class CartItemWidget extends StatelessWidget {
  final ProductModel product;
  const CartItemWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Container(
      padding: const EdgeInsets.all(25),
      height: screenSize.height / 2,
      width: screenSize.width,
      decoration: BoxDecoration(
        color: Colors.grey,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
      child: FittedBox(
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductScreen(productModel: product),
                      ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: screenSize.width / 3,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Center(
                          child: Image.network(product.url),
                        ),
                      ),
                    ),
                    ProductInformationWidget(
                      productName: product.productName,
                      cost: product.cost,
                      sellerName: product.sellerName,
                    )
                  ],
                ),
              ),
              flex: 3,
            ),
            Expanded(
              child: Row(
                children: [
                  CustomSquareButton(
                      child: const Icon(
                        Icons.remove,
                      ),
                      onPressed: () {},
                      color: Colors.grey,
                      dimension: 40),
                  CustomSquareButton(
                      child: Text("0", style: TextStyle(color: Colors.cyan)),
                      onPressed: () {},
                      color: Colors.white,
                      dimension: 40),
                  CustomSquareButton(
                      child: const Icon(Icons.add),
                      onPressed: () async {
                        await CloudFireStoreClass().addProductToCart(
                            productModel: ProductModel(
                                url: product.url,
                                productName: product.productName,
                                cost: product.cost,
                                discount: product.discount,
                                uid: Utils().getUid(),
                                sellerName: product.sellerName,
                                sellerUid: product.sellerUid,
                                rating: product.rating,
                                noOfRating: product.noOfRating));
                      },
                      color: Colors.grey,
                      dimension: 40),
                ],
              ),
              flex: 1,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 5,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        CustomSimpleRoundedButton(
                            onPressed: () async {
                              CloudFireStoreClass()
                                  .deleteProductFromCart(uid: product.uid);
                            },
                            text: "Delete"),
                        const SizedBox(width: 5),
                        CustomSimpleRoundedButton(
                            onPressed: () {}, text: "Save for later"),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 3),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "See more like this",
                          style: TextStyle(
                            color: Colors.cyan,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
