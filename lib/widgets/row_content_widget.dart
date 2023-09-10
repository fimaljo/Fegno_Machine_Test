import 'package:flutter/material.dart';

class RowContentWidget extends StatelessWidget {
  final Widget title;
  final Widget action;
  const RowContentWidget({
    super.key,
    required this.title,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title,
          action,
        ],
      ),
    );
  }
}
