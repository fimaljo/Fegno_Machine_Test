import 'package:flutter/material.dart';

import 'custom_shape.dart';

class SentMessageScreen extends StatelessWidget {
  final List<Widget> children;
  const SentMessageScreen({
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color mySColor = Color(0xFFE4FFE6);

    final messageTextGroup = Flexible(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.only(top: 14, bottom: 14),
            decoration: BoxDecoration(
              color: mySColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: children,
            ),
          ),
        ),
        CustomPaint(painter: CustomShape(mySColor)),
      ],
    ));

    return Padding(
      padding: const EdgeInsets.only(right: 18.0, left: 50, top: 15, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 30),
          messageTextGroup,
        ],
      ),
    );
  }
}
