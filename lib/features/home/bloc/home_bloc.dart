import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_flutter/data/cart_products.dart';
import 'package:bloc_flutter/data/grocery_data.dart';
import 'package:bloc_flutter/data/wishlist_products.dart';
import 'package:meta/meta.dart';

import '../models/product_data_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<ProductWishlistButtonClickedEvent>(productWishlistButtonClickedEvent);
    on<HomeInitialEvent>(homeInitialEvent);
    on<ProductCartButtonClickedEvent>(productCartButtonClickedEvent);
    on<WishlistButtonNavigateEvent>(wishlistButtonNavigateEvent);
    on<CartButtonNavigateEvent>(cartButtonNavigateEvent);
  }
  Future<FutureOr<void>> homeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    emit(HomeLoadedSuccessState(
        products: GroceryData.groceryProducts
            .map((e) => ProductDataModel(
                  id: e['id'],
                  name: e['name'],
                  description: e['description'],
                  price: e['price'],
                  imageUrl: e['imageUrl'],
                ))
            .toList()));
  }

  FutureOr<void> productWishlistButtonClickedEvent(
      ProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
    log("Wishlist clicked");
    wishlistProducts.add(event.product);
    emit(HomeProductAddedToWishlistState());
  }

  FutureOr<void> productCartButtonClickedEvent(ProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    log("Cart clicked");
    cartProducts.add(event.product);
    emit(HomeProductAddedToCartState());
  }

  FutureOr<void> wishlistButtonNavigateEvent(WishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    log("Navigate to Wishlist Page");
    emit(NavigateToWishlistPageState());
  }

  FutureOr<void> cartButtonNavigateEvent(CartButtonNavigateEvent event, Emitter<HomeState> emit) {
    log("Navigate to Cart Page");
    emit(NavigateToCartPageState());
  }
}
