import 'package:metamall/common/widgets/stars.dart';
import 'package:metamall/constants/global_variables.dart';
import 'package:metamall/features/cart/services/cart_services.dart';
import 'package:metamall/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/product.dart';
import '../../product_details/services/product_details_services.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  final CartServices cartServices = CartServices();

  void increaseQuantity(Product product) {
    productDetailsServices.addToCart(
      context: context,
      product: product,
    );
  }

  void decreaseQuantity(Product product) {
    cartServices.removeFromCart(
      context: context,
      product: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().user.cart[widget.index];
    final product = Product.fromMap(productCart['product']);
    final quantity = productCart['quantity'];

    double totalRating = 0;
    for (int i = 0; i < product.rating!.length; i++) {
      totalRating += product.rating![i].rating;
    }
    double avgRating = 0;

    if (totalRating != 0) {
      avgRating = totalRating / product.rating!.length;
    }

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: GlobalVariables.cardBackgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.contain,
                height: 96,
                width: 96,
              ),
              // Column(
              //   children: [
              // Container(
              //   width: 235,
              //   padding: const EdgeInsets.symmetric(horizontal: 10),
              //   child: Text(
              //     product.name,
              //     style: const TextStyle(
              //       fontSize: 16,
              //     ),
              //     maxLines: 2,
              //   ),
              // ),
              // Container(
              //   width: 235,
              //   padding: const EdgeInsets.only(left: 10, top: 5),
              //   child: Text(
              //     '₹${product.price}',
              //     style: const TextStyle(
              //       fontSize: 20,
              //       fontWeight: FontWeight.bold,
              //     ),
              //     maxLines: 2,
              //   ),
              // ),
              // Container(
              //   width: 235,
              //   padding: const EdgeInsets.only(left: 10),
              //   child: const Text('Eligible for FREE Shipping'),
              // ),
              // Container(
              //   width: 235,
              //   padding: const EdgeInsets.only(left: 10, top: 5),
              //   child: const Text(
              //     'In Stock',
              //     style: TextStyle(
              //       color: Colors.teal,
              //     ),
              //     maxLines: 2,
              //   ),
              // ),
              //   ],
              // ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                    ),
                    Text(
                      product.description,
                      style: const TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 2,
                    ),
                    Text(
                      'Exclusive Offer: Get 20% OFF when\nyou apply coupon across the site',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Free Delivery Upto Rs 499',
                      style: const TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 2,
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '₹${product.price}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                          ),
                          SizedBox(
                            width: 64,
                          ),
                          Stars(
                            rating: avgRating,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromRGBO(32, 32, 32, 1),
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => decreaseQuantity(product),
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12, width: 1.5),
                        color: Color.fromRGBO(63, 62, 66, 1),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: Text(
                          quantity.toString(),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => increaseQuantity(product),
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
