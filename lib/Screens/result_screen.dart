import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/Model/product_model.dart';
import 'package:flutter_guide/Widget/loading_widget.dart';
import 'package:flutter_guide/Widget/results_widget.dart';
import 'package:flutter_guide/Widget/search_bar_widget.dart';

class ResultScreen extends StatelessWidget {
  final String query;
  const ResultScreen({Key? key, required this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SearchBarWidget(isReadOnly: false, hasBackButton: true),
        body: Column(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Showing Results for ",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    TextSpan(
                      text: query,
                      style: TextStyle(
                        fontSize: 17,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("products")
                      .where('productName', isEqualTo: query)
                      .get(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot){
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const LoadingWidget();
                    } else {
                      return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 2 / 3.5,
                          ),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            ProductModel product =
                                ProductModel.getModelFromJson(
                                    json: snapshot.data!.docs[index].data());
                            return ResultWidget(product: product);
                          });
                    }
                  })),
        ]));
  }
}
