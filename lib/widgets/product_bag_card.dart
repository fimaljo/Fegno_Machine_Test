
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../application/bag/bloc/cart_bloc.dart';
import '../domain/bag/model/item.dart';

class ProductBagCard extends StatelessWidget {
  final String name;
  final String image;
  final int count;
  final int price;
  final int quantity;
  final String unit;
  final Item item;
  const ProductBagCard({
    super.key,
    required this.name,
    required this.image,
    required this.count,
    required this.price,
    required this.quantity,
    required this.unit,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    Color myGreenColor = const Color(0xFF008754);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(image),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
                width: 100,
                child: Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
              ),
              Text(
                '\u{20B9} ${price}',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              Text(
                '$quantity $unit',
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 15,
                    color: Colors.black),
              ),
            ],
          ),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return Row(
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: myGreenColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () =>
                          context.read<CartBloc>().add(CartItemAdded(item)),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(count.toString()),
                  ),
                  InkWell(
                    onTap: () =>
                        context.read<CartBloc>().add(CartItemRemoved(item)),
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: myGreenColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
