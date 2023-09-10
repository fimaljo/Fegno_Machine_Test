
import 'package:fegno_machine_test/presentation/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'application/bag/bloc/cart_bloc.dart';
import 'infrastructure/bag/shopping_repository.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.shoppingRepository});
  final ShoppingRepository shoppingRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => CartBloc(
                  shoppingRepository: shoppingRepository,
                )..add(CartStarted())
           
            ),
 
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
