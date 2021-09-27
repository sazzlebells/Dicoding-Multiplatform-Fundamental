import 'package:flutter/material.dart';
import 'package:restaurant_api/data/model/detail.dart';
import 'package:restaurant_api/widgets/review.dart';

class ReviewSection extends StatelessWidget {
  const ReviewSection({Key? key, required this.review}) : super(key: key);
  final Detail? review;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: review!.customerReviews!.length,
        itemBuilder: (context, i) {
          return ReviewTile(review: review!.customerReviews![i]);
        });
  }
}
