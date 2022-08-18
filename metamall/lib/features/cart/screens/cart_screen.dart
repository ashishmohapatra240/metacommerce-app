import 'package:metamall/common/widgets/custom_button.dart';
import 'package:metamall/constants/global_variables.dart';
import 'package:metamall/features/address/screens/address_screen.dart';
import 'package:metamall/features/cart/widgets/cart_product.dart';
import 'package:metamall/features/cart/widgets/cart_subtotal.dart';
import 'package:metamall/features/home/screens/widgets/address_box.dart';
import 'package:metamall/features/search/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/user_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void navigateToAddress(int sum) {
    Navigator.pushNamed(context, AddressScreen.routeName,
        arguments: sum.toString());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    int sum = 0;
    user.cart
        .map(
          (e) => sum += e['quantity'] * e['product']['price'] as int,
        )
        .toList();


    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Cart',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                child: Container(
                  height: 48,
                  decoration: const BoxDecoration(
                      color: GlobalVariables.cardBackgroundColor),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Items Selected',
                          style: TextStyle(fontSize: 12),
                        ),
                        Container(
                          height: 20,
                          width: 20,
                          child: Center(child: Text('${user.cart.length}')),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 236, 0, 140),
                                Color.fromARGB(255, 252, 103, 103),
                              ],
                              stops: [0.25, 0.75],
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // CartSubtotal(),
              const SizedBox(
                height: 50,
              ),
              Container(
                color: Colors.black12.withOpacity(0.08),
              ),
              const SizedBox(
                height: 5,
              ),
              ListView.builder(
                itemCount: user.cart.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CartProduct(index: index);
                },
              ),
              SizedBox(height: 96,),
              CustomButton(
                text: 'Proceed to Checkout ₹$sum/-',
                onTap: () => navigateToAddress(sum),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
