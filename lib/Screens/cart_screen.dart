import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/Model/user_details.dart';
import 'package:flutter_guide/Providers/user_details_provider.dart';
import 'package:flutter_guide/Resources/cloudFirestoreMethods.dart';
import 'package:flutter_guide/Resources/const.dart';
import 'package:flutter_guide/Screens/Utils/utils.dart';
import 'package:flutter_guide/Widget/cart_item_widget.dart';
import 'package:flutter_guide/Widget/custom_primary_widget.dart';
import 'package:flutter_guide/Widget/user_details_bar.dart';
import 'package:provider/provider.dart';

import '../Model/product_model.dart';
import '../Widget/search_bar_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SearchBarWidget(
          hasBackButton: false,
          isReadOnly: true,
        ),
        body: Center(
          child: Stack(
            children: [
              Column(children: [
                const SizedBox(height: kAppBarHeight / 2),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection("cart")
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CustomMainButton(
                              child: Text(
                                "Loading",
                              ),
                              color: Colors.yellow,
                              isLoading: true,
                              onPressed: () {});
                        } else {
                          return CustomMainButton(
                              child: Text(
                                  "Proceed to buy (${snapshot.data!.docs.length}) items",
                                  style: TextStyle(
                                    color: Colors.black,
                                  )),
                              color: Colors.yellow,
                              isLoading: false,
                              onPressed: () async {
                                await CloudFireStoreClass().buyAllItemsinCart(
                                    userDetails:
                                        Provider.of<UserDetailsProvider>(
                                                context, listen: false)
                                            .userDetails);
                                Utils().showSnackBar(
                                    context: context, content: "Done");
                              });
                        }
                      }),
                ),
                Expanded(
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("users")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("cart")
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
                                  ProductModel model =
                                      ProductModel.getModelFromJson(
                                          json: snapshot.data!.docs[index]
                                              .data());
                                  return CartItemWidget(product: model);
                                });
                          }
                        })),
              ]),
              UserDetailsBar(
                offset: 0,
              ),
            ],
          ),
        ));
  }
}
