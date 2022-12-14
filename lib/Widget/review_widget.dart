import 'package:flutter/material.dart';
import 'package:flutter_guide/Model/review_model.dart';
import 'package:flutter_guide/Resources/const.dart';
import 'package:flutter_guide/Screens/Utils/utils.dart';
import 'package:flutter_guide/Widget/rating_star.dart';

class ReviewWidget extends StatelessWidget {
  final ReviewModel review;
  const ReviewWidget({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          review.senderName,
          style: const TextStyle(
            //color: Colors.cyan,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: SizedBox(
                  width: screenSize.width/4,
                  child: FittedBox(
                    child: RatingStartWidget(rating: review.rating)
                  )
                ),
              ),
              Text(keysOfRating[review.rating-1], style: const TextStyle(fontWeight : FontWeight.bold),)
            ],
          ),
        ),
        Text(review.description, maxLines: 3, overflow: TextOverflow.ellipsis,)
      ],),
    );
  }
}
