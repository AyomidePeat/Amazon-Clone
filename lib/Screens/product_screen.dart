import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/Model/product_model.dart';
import 'package:flutter_guide/Model/review_model.dart';
import 'package:flutter_guide/Model/user_details.dart';
import 'package:flutter_guide/Providers/user_details_provider.dart';
import 'package:flutter_guide/Resources/cloudFirestoreMethods.dart';
import 'package:flutter_guide/Resources/const.dart';
import 'package:flutter_guide/Screens/Utils/utils.dart';
import 'package:flutter_guide/Widget/cost_widget.dart';
import 'package:flutter_guide/Widget/custom_primary_widget.dart';
import 'package:flutter_guide/Widget/custom_simple_rounded.dart';
import 'package:flutter_guide/Widget/rating_star.dart';
import 'package:flutter_guide/Widget/review_dialog.dart';
import 'package:flutter_guide/Widget/review_widget.dart';
import 'package:flutter_guide/Widget/user_details_bar.dart';
import 'package:provider/provider.dart';

import '../Widget/search_bar_widget.dart';

class ProductScreen extends StatefulWidget {
  final ProductModel productModel;
  const ProductScreen({Key? key, required this.productModel}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Expanded spacer = Expanded(child: Container());
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return SafeArea(
      child: Scaffold(
        appBar: SearchBarWidget(
          isReadOnly: true,
          hasBackButton: true,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: screenSize.height -
                        (kAppBarHeight + (kAppBarHeight / 2)),
                    child: Column(
                      children: [
                        const SizedBox(height: kAppBarHeight / 2),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      widget.productModel.sellerName,
                                      style: const TextStyle(
                                        color: Colors.cyan,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    widget.productModel.productName,
                                  ),
                                ],
                              ),
                              RatingStartWidget(
                                  rating: widget.productModel.rating),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            height: screenSize.height / 3,
                            constraints: BoxConstraints(
                                maxHeight: screenSize.height / 3),
                            //width:screenSize.width

                            child: Image.network(widget.productModel.url),
                          ),
                        ),
                        spacer,
                        CostWidget(
                            color: Colors.black,
                            cost: widget.productModel.cost),
                        spacer,
                        CustomMainButton(
                          child: Text(
                            "Buy Now",
                            style: TextStyle(color: Colors.black),
                          ),
                          color: Colors.orange,
                          isLoading: false,
                          onPressed: () async {
                            await CloudFireStoreClass().addProductToOrders(
                                model: widget.productModel,
                                userDetails:
                                    Provider.of<UserDetailsProvider>(context, listen: false,)
                                        .userDetails);
                            Utils().showSnackBar(
                                context: context, content: "Added to orders");
                          },
                        ),
                        spacer,
                        CustomMainButton(
                          child: Text(
                            "Add to Cart",
                            style: TextStyle(color: Colors.black),
                          ),
                          color: Colors.yellow,
                          isLoading: false,
                          onPressed: () async {
                            await CloudFireStoreClass().addProductToCart(
                                productModel: widget.productModel);
                            Utils().showSnackBar(
                                context: context, content: "Added to cart");
                          },
                        ),
                        spacer,
                        CustomSimpleRoundedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => ReviewDialog(
                                productUid: widget.productModel.uid,
                              ),
                            );
                          },
                          text: "Review this product ",
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                      height: screenSize.height,
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("products")
                              .doc(widget.productModel.uid)
                              .collection("reviews")
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                  snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container();
                            } else {
                              return ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    ReviewModel model =
                                        ReviewModel.getModelFromJson(
                                            json: snapshot.data!.docs[index]
                                                .data());
                                    return ReviewWidget(review: model);
                                  });
                            }
                          })),
                ],
              ),
            )),
            const UserDetailsBar(
              offset: 0,
            )
          ],
        ),
      ),
    );
  }
}
