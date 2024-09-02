import 'package:bloc_flutter/features/cart/bloc/cart_bloc.dart';
import 'package:bloc_flutter/features/home/models/product_data_model.dart';
import 'package:flutter/material.dart';

class CartProductCard extends StatelessWidget {
  final ProductDataModel product;
  final CartBloc cartBloc;
  const CartProductCard({super.key, required this.product, required this.cartBloc});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        //padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Image.network(product.imageUrl, height: 150, width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Text(product.description),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${product.price}",
                        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          // IconButton(
                          //     onPressed: () {
                          //       //cartBloc.add(ProductWishlistButtonClickedEvent(product: product));
                          //     },
                          //     icon: const Icon(Icons.favorite_outline_rounded)),
                          IconButton(
                            onPressed: () {
                              cartBloc.add(RemoveCartProductEvent(product: product));
                            },
                            //icon: const Icon(Icons.shopping_bag_outlined),
                            icon: const Icon(Icons.delete_forever),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
