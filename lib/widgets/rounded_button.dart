import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color, textColor;
  final bool needIcon;
  final IconData iconData;
  const RoundedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = Colors.white,
    this.textColor = Colors.white,
    this.needIcon = false,
    this.iconData = Icons.no_accounts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Color myGreenColor = const Color(0xFF008754);
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 50, bottom: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: Container(
          width: size.width * 0.9,
          decoration: BoxDecoration(
            color: color,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                  visible: needIcon,
                  child: Icon(
                    iconData,
                    color: myGreenColor,
                  )),
              TextButton(
                onPressed: onPressed,
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 15,
                      color: textColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
