part of 'cart_bloc.dart';

@immutable
sealed class CartEvent extends Equatable {
  const CartEvent();
}

final class CartStarted extends CartEvent {
  @override
  List<Object> get props => [];
}

final class CouponAdded extends CartEvent {
  final int data;
  final Coupon item;

  const CouponAdded(
    this.item,
    this.data,
  );

  @override
  List<Object> get props => [];
}

final class CoupenSkiped extends CartEvent {
  final bool data;

  const CoupenSkiped(
    this.data,
  );

  @override
  List<Object> get props => [];
}

final class TakeAwaySelected extends CartEvent {
  final bool data;

  const TakeAwaySelected(
    this.data,
  );

  @override
  List<Object> get props => [];
}

final class AddInstruction extends CartEvent {
  final bool data;

  const AddInstruction(
    this.data,
  );

  @override
  List<Object> get props => [];
}

final class CartItemAdded extends CartEvent {
  const CartItemAdded(
    this.item,
  );

  final Item item;

  @override
  List<Object> get props => [item];
}

final class TimeSloteAdded extends CartEvent {
  const TimeSloteAdded(
    this.item,
  );

  final TimeSlot item;

  @override
  List<Object> get props => [item];
}

final class CartItemRemoved extends CartEvent {
  const CartItemRemoved(this.item);

  final Item item;

  @override
  List<Object> get props => [item];
}
