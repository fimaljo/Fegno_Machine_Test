import 'package:fegno_machine_test/widgets/text_field_container.dart';

import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
 final TextEditingController controller;

  const RoundedInputField({
    Key? key,
    required this.hintText,
    this.icon = Icons.person,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
       Size size = MediaQuery.of(context).size;
    return TextFieldContainer(
      width: size.width * 0.8,
      child: TextFormField(
      controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
