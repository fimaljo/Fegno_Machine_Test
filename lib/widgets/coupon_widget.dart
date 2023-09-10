
import 'package:flutter/material.dart';

class CouponWidget extends StatelessWidget {
  final double firstTextSize;
  final double secondTextSize;
  final String firstText;
  final String secondText;
  const CouponWidget({
    super.key,
    this.firstTextSize = 20,
    this.secondTextSize = 15,
    required this.firstText,
    required this.secondText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset("assets/icons/DISCOUNT_ICON-removebg-preview.png"),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              firstText,
              style: TextStyle(
                  fontWeight: FontWeight.w500, fontSize: firstTextSize),
            ),
            Text(
              secondText,
              style: TextStyle(
                  fontWeight: FontWeight.w300, fontSize: secondTextSize),
            ),
          ],
        )
      ],
    );
  }
}