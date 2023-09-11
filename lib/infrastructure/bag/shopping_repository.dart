import 'dart:async';



import '../../domain/bag/model/coupon.dart';
import '../../domain/bag/model/discount.dart';
import '../../domain/bag/model/group_value.dart';
import '../../domain/bag/model/item.dart';
import '../../domain/bag/model/time_slot.dart';

const _delay = Duration(milliseconds: 50);


class ShoppingRepository {
  final _items = <Item>[
    Item(1, "Green Apple", "assets/images/is-a-green-apple-always-green.jpg", 1,
        100, 2, "Kg", 0),
    Item(1, "Apple", "assets/images/apple.jpg", 1, 10, 500, "g", 0)
  ];

  final _coupons = <Coupon>[
    Coupon(1, 10, 0),
    Coupon(1, 20, 0),
    Coupon(1, 30, 0),
    Coupon(1, 40, 0)
  ];
  final _discount = <Discount>[];
  final _groupValue = <GroupValue>[GroupValue(false, false,false)];
  final _timeSlots = <TimeSlot>[
    TimeSlot("10 am to 12 pm", false),
    TimeSlot("12 am to 2 pm", false),
    TimeSlot("2 am to 4 pm", false),
  
  ];
  Future<List<Item>> loadCartItems() => Future.delayed(_delay, () => _items);

  Future<List<Coupon>> loadCoupons() => Future.delayed(_delay, () => _coupons);
  Future<List<Discount>> loadDiscount() =>
      Future.delayed(_delay, () => _discount);
  Future<List<TimeSlot>> loadTimeSlot() =>
      Future.delayed(_delay, () => _timeSlots);
  Future<List<GroupValue>> loadGroupBool() =>
      Future.delayed(_delay, () => _groupValue);
}
