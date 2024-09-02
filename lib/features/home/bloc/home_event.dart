part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class ProductWishlistButtonClickedEvent extends HomeEvent {
  final ProductDataModel product;

  ProductWishlistButtonClickedEvent({required this.product});
}

class ProductCartButtonClickedEvent extends HomeEvent {
  final ProductDataModel product;

  ProductCartButtonClickedEvent({required this.product});
}

class WishlistButtonNavigateEvent extends HomeEvent {}

class CartButtonNavigateEvent extends HomeEvent {}
