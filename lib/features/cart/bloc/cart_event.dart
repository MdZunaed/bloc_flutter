part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartInitialEvent extends CartEvent {}

class RemoveCartProductEvent extends CartEvent {
  final ProductDataModel product;
  RemoveCartProductEvent({required this.product});
}
