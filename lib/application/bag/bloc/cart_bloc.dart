import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import 'package:meta/meta.dart';

import '../../../domain/bag/model/cart.dart';
import '../../../domain/bag/model/coupon.dart';
import '../../../domain/bag/model/discount.dart';
import '../../../domain/bag/model/item.dart';
import '../../../domain/bag/model/time_slot.dart';
import '../../../infrastructure/bag/shopping_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({required this.shoppingRepository}) : super(CartLoading()) {
    on<CartStarted>(_onStarted);
    on<CouponAdded>(_onCouponAdded);
    on<CartItemAdded>(_onItemCountAdded);
    on<CartItemRemoved>(_onItemCountRemoved);
    on<TimeSloteAdded>(_onTimeSloteAdded);
    on<CoupenSkiped>(_onCoupenSkiped);
    on<TakeAwaySelected>(_onTakeAwaySelected);
  }

  final ShoppingRepository shoppingRepository;

  Future<void> _onStarted(CartStarted event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final items = await shoppingRepository.loadCartItems();
      final coupons = await shoppingRepository.loadCoupons();
      final discount = await shoppingRepository.loadDiscount();
      final timeSlots = await shoppingRepository.loadTimeSlot();
      final groupBoolValue = await shoppingRepository.loadGroupBool();
      emit(
        CartLoaded(
          cart: Cart(
              items: [...items],
              coupons: [...coupons],
              discounts: [...discount],
              timeSlots: [...timeSlots],
              groupBoolValue: groupBoolValue),
        ),
      );
    } catch (_) {
      emit(CartError());
    }
  }

  Future<void> _onItemCountAdded(
    CartItemAdded event,
    Emitter<CartState> emit,
  ) async {
    final state = this.state;
    if (state is CartLoaded) {
      try {
       
        final index = state.cart.items.indexOf(event.item);
        if (index != -1) {
          state.cart.items[index].count = state.cart.items[index].count + 1;
        }

      

        emit(CartLoading());
        emit(CartLoaded(cart: state.cart));
      } catch (_) {
        emit(CartError());
      }
    }
  }

  Future<void> _onTimeSloteAdded(
    TimeSloteAdded event,
    Emitter<CartState> emit,
  ) async {
    final state = this.state;
    if (state is CartLoaded) {
      try {
       
        final index = state.cart.timeSlots.indexOf(event.item);
        if (index != -1) {
          state.cart.timeSlots[index].selectedTimeZone = true;
        }

        emit(CartLoading());
        emit(CartLoaded(cart: state.cart));
      } catch (e) {
       
        emit(CartError());
      }
    }
  }

  Future<void> _onCouponAdded(
    CouponAdded event,
    Emitter<CartState> emit,
  ) async {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        Discount data = Discount(event.data);
        state.cart.discounts.add(data);
        final items = await shoppingRepository.loadCartItems();
        final groupBoolValue = await shoppingRepository.loadGroupBool();
        final timeSlots = await shoppingRepository.loadTimeSlot();
        emit(CartLoading());
        emit(
          CartLoaded(
            cart: Cart(
                items: [...items],
                coupons: [...state.cart.coupons]..remove(event.item),
                discounts: [...state.cart.discounts],
                timeSlots: [...timeSlots],
                groupBoolValue: [...groupBoolValue]),
          ),
        );
      } catch (e) {
      
        emit(CartError());
      }
    }
  }

  Future<void> _onItemCountRemoved(
    CartItemRemoved event,
    Emitter<CartState> emit,
  ) async {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        final index = state.cart.items.indexOf(event.item);
        if (index != -1) {
          state.cart.items[index].count = state.cart.items[index].count - 1;
        }

        emit(CartLoading());
        emit(
          CartLoaded(cart: state.cart),
        );
      } catch (_) {
        emit(CartError());
      }
    }
  }

  Future<void> _onCoupenSkiped(
    CoupenSkiped event,
    Emitter<CartState> emit,
  ) async {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        state.cart.groupBoolValue[0].couponSkiped = event.data;

        emit(CartLoading());
        emit(
          CartLoaded(cart: state.cart),
        );
      } catch (e) {
        emit(CartError());
      }
    }
  }

  Future<void> _onTakeAwaySelected(
    TakeAwaySelected event,
    Emitter<CartState> emit,
  ) async {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        state.cart.groupBoolValue[0].isTakeAwaySelected = event.data;

        emit(CartLoading());
        emit(
          CartLoaded(cart: state.cart),
        );
      } catch (e) {
        emit(CartError());
      }
    }
  }
}
