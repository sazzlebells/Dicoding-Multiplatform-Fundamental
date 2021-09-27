import 'package:flutter/material.dart';
import 'package:restaurant_api/common/style.dart';
import 'package:restaurant_api/data/model/detail.dart';

class ReviewTile extends StatelessWidget {
  const ReviewTile({Key? key, required this.review}) : super(key: key);
  final CustomerReview? review;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            border: Border.all(color: primaryColor, width: 3),
            color: secondaryColor,
          ),
          child: Center(
              child: Text(review!.name.toString()[0],
                  style: TextStyle(color: primaryColor))),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text("${review!.name}", style: myTextTheme.subtitle2),
            Text("${review!.date}", style: myTextTheme.overline),
          ],
        ),
        subtitle: Text("${review!.review}", style: myTextTheme.subtitle1),
      ),
    );
  }
}
