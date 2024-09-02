part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeLoadedSuccessState extends HomeState {
  final List<ProductDataModel> products;

  HomeLoadedSuccessState({required this.products});
}

final class HomeErrorState extends HomeState {}

final class NavigateToWishlistPageState extends HomeActionState {}

final class NavigateToCartPageState extends HomeActionState {}

final class HomeProductAddedToWishlistState extends HomeActionState {}

final class HomeProductAddedToCartState extends HomeActionState {}
