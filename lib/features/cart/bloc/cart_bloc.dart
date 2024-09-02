import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_flutter/data/cart_products.dart';
import 'package:meta/meta.dart';

import '../../home/models/product_data_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<RemoveCartProductEvent>(cartRemoveFromCartEvent);
  }

  FutureOr<void> cartInitialEvent(CartInitialEvent event, Emitter<CartState> emit) {
    emit(CartSuccessState(cartItems: cartProducts));
  }

  FutureOr<void> cartRemoveFromCartEvent(RemoveCartProductEvent event, Emitter<CartState> emit) {
    cartProducts.remove(event.product);
    emit(CartSuccessState(cartItems: cartProducts));
  }
}
