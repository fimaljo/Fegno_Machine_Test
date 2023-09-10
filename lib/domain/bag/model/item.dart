import 'package:equatable/equatable.dart';

class Item extends Equatable {
  Item(this.id, this.name, this.image, this.count, this.price, this.quantity,
      this.unit, this.discount);

  final int id;
  final String name;
  final String image;
  int count;
  final int price;
  final int quantity;
  final String unit;
 int discount;
  @override
  List<Object> get props => [id, name, image, price, count, quantity, unit];
}
