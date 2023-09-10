import 'package:equatable/equatable.dart';

class Coupon extends Equatable {
  Coupon(this.couponCode, this.discountAmount, this.disCountAdded);

  final int couponCode;

  final int discountAmount;
  int disCountAdded;

  @override
  List<Object> get props => [couponCode, discountAmount, disCountAdded];
}
