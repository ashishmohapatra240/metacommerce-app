import 'dart:ffi';

import 'package:metamall/constants/global_variables.dart';
import 'package:metamall/models/product.dart';
import 'package:metamall/common/widgets/stars.dart';
import 'package:metamall/provider/user_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchedProduct extends StatelessWidget {
  final Product product;
  const SearchedProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        Padding(
          padding: const EdgeInsets.all(24),
          child: Container(
            decoration: BoxDecoration(
                color: GlobalVariables.cardBackgroundColor,
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: Image.network(
                    product.images[0],
                    fit: BoxFit.contain,
                    height: 96,
                    width: 96,
                  ),
                ),
                Column(
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
