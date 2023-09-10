
import 'package:flutter/material.dart';

import 'infrastructure/bag/shopping_repository.dart';
import 'my_app.dart';

void main() {
  runApp(MyApp(
    shoppingRepository: ShoppingRepository(),
  ));
}


