import 'package:metamall/common/widgets/loader.dart';
import 'package:metamall/constants/global_variables.dart';
import 'package:metamall/features/home/screens/widgets/address_box.dart';
import 'package:metamall/features/product_details/screens/product_details_screen.dart';
import 'package:metamall/features/search/services/search_services.dart';
import 'package:metamall/features/search/widgets/searched_product.dart';
import 'package:metamall/models/product.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;
  const SearchScreen({super.key, required this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products;
  final SearchServices searchServices = SearchServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSearchedProducts();
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  fetchSearchedProducts() async {
    products = await searchServices.fetchSearchedProducts(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: GlobalVariables.backgroundColor,
          ),
        ),
        title: const AddressBox(),
      ),
      body: products == null
          ? const Loader()
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: 42,
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        child: Material(
                          borderRadius: BorderRadius.circular(7),
                          elevation: 1,
                          child: TextFormField(
                            onFieldSubmitted: navigateToSearchScreen,
                            decoration: InputDecoration(
                              prefixIcon: InkWell(
                                onTap: () {},
                                child: const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.search,
                                    color: Color.fromRGBO(157, 157, 157, 1),
                                    size: 24,
                                  ),
                                ),
                              ),
                              filled: true,
                              fillColor: GlobalVariables.cardBackgroundColor,
                              contentPadding: const EdgeInsets.all(8),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                borderSide: BorderSide(color: Colors.black38),
                              ),
                              hintText: 'Search your desire',
                              hintStyle: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: products!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ProductDetailScreen.routeName,
                            arguments: products![index],
                          );
                        },
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              ProductDetailScreen.routeName,
                              arguments: products![index],
                            );
                          },
                          child: SearchedProduct(
                            product: products![index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
