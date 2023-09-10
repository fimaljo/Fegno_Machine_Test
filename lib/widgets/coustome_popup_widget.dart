
import 'package:flutter/material.dart';


import '../domain/bag/model/coupon.dart';
import 'dol_druma_clipper.dart';

class CustomPopupWidget extends StatelessWidget {
  const CustomPopupWidget({super.key, required this.couponData});
  final Coupon couponData;
  @override
  Widget build(BuildContext context) {
    Color myGreenColor = const Color(0xFF008754);
    return SizedBox(
      height: 250,
      width: 200,
      child: ClipPath(
        clipper: DolDurmaClipper(holeRadius: 20),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(29),
            child: Material(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "COUPON APPLIED!",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                  Image.asset("assets/images/couponGift-removebg-preview.png"),
                  const Text(
                    "Congragulations, you saved",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                  ),
                  Text(
                    '\u{20B9} ${couponData.discountAmount}',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: myGreenColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
