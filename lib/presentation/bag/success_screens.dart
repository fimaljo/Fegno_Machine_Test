import 'package:flutter/material.dart';

import '../../widgets/rounded_button.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color myGreenColor = const Color(0xFF008754);

    return Scaffold(
      backgroundColor: myGreenColor,
      body: Center(
        // Wrap the Column with Center
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "HOOORAY!!!",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Center(
                child: Icon(
                  Icons.check,
                  size: 50,
                  weight: 10,
                  color: myGreenColor,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Your order has been\nplaced successfully",
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 18,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: SizedBox(
                width: 300,
                height: 70,
                child: RoundedButton(
                  text: "Continue Shopping",
                  textColor: myGreenColor,
                  color: Colors.white,
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
