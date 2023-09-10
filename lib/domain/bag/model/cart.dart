
import 'package:equatable/equatable.dart';
import 'package:fegno_machine_test/domain/bag/model/coupon.dart';
import 'package:fegno_machine_test/domain/bag/model/time_slot.dart';

import 'discount.dart';
import 'group_value.dart';
import 'item.dart';

class Cart extends Equatable {
  const Cart(
      {this.coupons = const <Coupon>[],
      this.items = const <Item>[],
      this.discounts = const <Discount>[],
      this.timeSlots = const <TimeSlot>[],
      this.groupBoolValue = const <GroupValue>[]});

  final List<Item> items;
  final List<Coupon> coupons;
  final List<Discount> discounts;
  final List<TimeSlot> timeSlots;
  final List<GroupValue> groupBoolValue;

  int get totalPrice {
    return items.fold(
        0, (total, current) => total + (current.price * current.count));
  }

  String get selectedTime {
    final selectedSlots = timeSlots
        .where((timeSlot) => timeSlot.selectedTimeZone == true)
        .map((timeSlot) => timeSlot.timeSlotes)
        .toList();

    return selectedSlots.join(', ');
  }

  int get discount {
    int discountTotal =
        discounts.fold(0, (total, current) => current.disCountAdded + total);
   
    if (totalPrice <= 300) {
      return totalPrice;
    }
    return totalPrice - discountTotal;
  }

  int get gainedDiscount {
    return discounts.fold(0, (total, current) => current.disCountAdded + total);
  }

  bool get couponAvilCheck {
    bool isTotalPriceGreaterThan300 = items.fold(
          0,
          (total, current) => total + (current.price * current.count),
        ) >=
        300;

    return isTotalPriceGreaterThan300;
  }

  int get couponAvilePrice {
    int price = items.fold(
        0, (total, current) => total + (current.price * current.count));
    int discount = 300;

    int result = price - discount;

    int absoluteResult = result.abs();

    return absoluteResult;
  }

  @override
  List<Object> get props => [items];
}
