import 'package:bloc_flutter/features/cart/ui/cart.dart';
import 'package:bloc_flutter/features/home/bloc/home_bloc.dart';
import 'package:bloc_flutter/features/home/ui/product_card.dart';
import 'package:bloc_flutter/features/wishlist/ui/wishlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    homeBloc.add(HomeInitialEvent());
  }

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is NavigateToWishlistPageState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const Wishlist()));
        } else if (state is NavigateToCartPageState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const Cart()));
        } else if (state is HomeProductAddedToWishlistState) {
          // ScaffoldMessenger.of(context)
          //     .showSnackBar(const SnackBar(content: Text("Product added to wishlist")));
          showSnackBar(context, text: "Product added to wishlist");
        } else if (state is HomeProductAddedToCartState) {
          showSnackBar(context, text: "Product added to Cart");
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case const (HomeLoadingState):
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case const (HomeLoadedSuccessState):
            final successState = state as HomeLoadedSuccessState;
            final products = successState.products;
            return Scaffold(
              appBar: AppBar(
                title: const Text("Products"),
                actions: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(WishlistButtonNavigateEvent());
                      },
                      icon: const Icon(CupertinoIcons.heart_circle_fill)),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(CartButtonNavigateEvent());
                      },
                      icon: const Icon(CupertinoIcons.bag_fill)),
                ],
              ),
              body: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                physics: const BouncingScrollPhysics(),
                itemCount: products.length,
                separatorBuilder: (c, i) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductCard(product: product, homeBloc: homeBloc);
                },
              ),
            );
          case const (HomeErrorState):
            return const Scaffold(
              body: Center(
                child: Text("Something went wrong!"),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }

  void showSnackBar(BuildContext context, {required text}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 1300),
    ));
  }
}
