import 'package:metamall/common/widgets/3dviewer.dart';
import 'package:metamall/common/widgets/custom_button.dart';
import 'package:metamall/common/widgets/stars.dart';
import 'package:metamall/constants/global_variables.dart';
import 'package:metamall/features/product_details/services/product_details_services.dart';
import 'package:metamall/features/search/screens/search_screen.dart';
import 'package:metamall/models/product.dart';
import 'package:metamall/provider/user_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  static const String routeName = '/product-details';
  final Product product;
  const ProductDetailScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  double avgRating = 0;
  double myRating = 0;

  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    // for (var rating in widget.product.rating!) {
    //   totalRating += rating.rating;
    //   if (rating.userId ==
    //       Provider.of<UserProvider>(context, listen: false).user.id) {
    //     myRating = rating.rating;
    //   }
    // }

    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
      }
    }

    if (totalRating != 0.0) {
      avgRating = totalRating / widget.product.rating!.length;
    }
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void addToCart() {
    productDetailsServices.addToCart(
      context: context,
      product: widget.product,
    );
  }

  void navigateToModelViewer() {
    Navigator.pushNamed(context, View3d.routeName,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Details',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product.id!,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 10,
              ),
              child: Text(
                widget.product.name,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            Stack(
              children: [
                CarouselSlider(
                  items: widget.product.images.map(
                    (i) {
                      return Builder(
                        builder: (BuildContext context) => Image.network(
                          i,
                          fit: BoxFit.contain,
                          height: 200,
                        ),
                      );
                    },
                  ).toList(),
                  options: CarouselOptions(
                    viewportFraction: 1,
                    height: 300,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 24,
                  child: InkWell(
                    onTap: navigateToModelViewer,
                    child: Image.asset(
                      'assets/images/3d.png',
                      height: 24,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              alignment: FractionalOffset.bottomCenter,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36),
                    topRight: Radius.circular(36),
                  ),
                  color: GlobalVariables.cardBackgroundColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 24, top: 24),
                        child: Text(
                          widget.product.name,
                          style:
                              TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, top: 4),
                    child: Text(
                      widget.product.category,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(102, 102, 102, 1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Stars(
                              rating: avgRating,
                            ),
                            Text(
                              '(${widget.product.rating!.length} Reviews)',
                              style: TextStyle(
                                  color: Color.fromRGBO(180, 182, 201, 1)),
                            ),
                          ],
                        ),
                        Text(
                          'Available in stock',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.only(left: 24, right: 24),
                    child: Text(
                      'Description',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Text(
                      widget.product.description,
                      style: TextStyle(color: Color.fromRGBO(102, 102, 102, 1)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.only(left: 24, right: 24),
                    child: Text(
                      'Rate The Product',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: RatingBar.builder(
                      initialRating: myRating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemSize: 30,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: GlobalVariables.secondaryColor,
                      ),
                      onRatingUpdate: (rating) {
                        productDetailsServices.rateProduct(
                          context: context,
                          product: widget.product,
                          rating: rating,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total Price'),
                            Text(
                              '₹ ${widget.product.price.toString()}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Container(
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: CustomButton(
                              text: 'Add to Cart',
                              onTap: addToCart,
                              // onTap: () {},
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
