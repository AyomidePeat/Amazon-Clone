import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/Model/Order_request_model.dart';
import 'package:flutter_guide/Model/product_model.dart';
import 'package:flutter_guide/Model/user_details.dart';
import 'package:flutter_guide/Providers/user_details_provider.dart';
import 'package:flutter_guide/Resources/const.dart';
import 'package:flutter_guide/Screens/Utils/utils.dart';
import 'package:flutter_guide/Screens/sell_screen.dart';
import 'package:flutter_guide/Widget/custom_primary_widget.dart';
import 'package:flutter_guide/Widget/introduction_widget.dart';
import 'package:flutter_guide/Widget/product_showcase_list_view.dart';
import 'package:flutter_guide/Widget/simple_product_widget.dart';
import 'package:provider/provider.dart';

import '../Widget/account_screen_appbar_widget.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    var userDetailsModel;
    List<Color> backgroundGradient = [Color(0xffa0e9ce), Color(0xff80d9e9)];
    UserDetailsModel userDetails =
        Provider.of<UserDetailsProvider>(context).userDetails;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AccountScreenAppbar(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height - (kAppBarHeight / 2),
          width: screenSize.width,
          child: Column(
            children: [
              FittedBox(
                child: Container(
                  height: kAppBarHeight / 2,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.white,
                    Colors.white.withOpacity(0.00000000001)
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 17),
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: "Hello, ",
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 25,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: "Peace ",
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ])),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 40),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://m.media-amazon.com/images/I/01cPTp7SLWL._SX90_SY90_.png"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomMainButton(
                  child: const Text(
                    "Sign in",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  color: Colors.orange,
                  isLoading: false,
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomMainButton(
                  child: const Text(
                    "Sell",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  color: Colors.orange,
                  isLoading: false,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SellScreen()),
                    );
                  },
                ),
              ),
              FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("orders")
                      .get(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else {
                      List<Widget> children = [];
                      for (int i = 0; i < snapshot.data!.docs.length; i++) {
                        ProductModel model = ProductModel.getModelFromJson(
                            json: snapshot.data!.docs[i].data());
                        children.add(SimpleProductWidget(productModel: model));
                      }
                      return ProductsShowCaseListView(
                          title: "Your Orders", children: children);
                    }
                  }),
              const Padding(
                padding: EdgeInsets.all(15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Order Requests",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("orderRequests")
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            OrderRequestModel model =
                                OrderRequestModel.getModelFromJson(
                                    json: snapshot.data!.docs[index].data());
                            return ListTile(
                              title: Text(
                                "Order:${model.orderName}",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text("Address: ${model.buyersAddress}"),
                              trailing: IconButton(
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .collection("orderRequests")
                                      .doc(snapshot.data!.docs[index].id)
                                      .delete();
                                },
                                icon: Icon(Icons.check),
                              ),
                            );
                          },
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
