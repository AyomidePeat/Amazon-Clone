import 'package:flutter/material.dart';
import 'package:flutter_guide/Model/review_model.dart';
import 'package:flutter_guide/Providers/user_details_provider.dart';
import 'package:flutter_guide/Resources/cloudFirestoreMethods.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';

class ReviewDialog extends StatelessWidget {
  final String productUid;
  const ReviewDialog({Key? key, required this.productUid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingDialog(
      initialRating: 1.0,
      // your app's name?
      title: const Text(
        'Type your Review',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      // encourage your user to leave a high rating?

      submitButtonText: 'Send',
      commentHint: 'Type here',
      onCancelled: () => print('cancelled'),
      onSubmitted: (RatingDialogResponse res) async {
        CloudFireStoreClass().uploadReviewToDatabase(
            productUid: productUid,
            model: ReviewModel(
                senderName:
                    Provider.of<UserDetailsProvider>(context, listen: false)
                        .userDetails
                        .name,
                description: res.comment,
                rating: res.rating.toInt()));
        print(res.comment);
        print(res.rating);
      },
    );

    // show the dialog
  }
}
