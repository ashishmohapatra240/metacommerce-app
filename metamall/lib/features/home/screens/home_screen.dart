import 'package:metamall/constants/global_variables.dart';
import 'package:metamall/features/home/screens/widgets/address_box.dart';
import 'package:metamall/features/home/screens/widgets/carousel_images.dart';
import 'package:metamall/features/home/screens/widgets/deal_of_the_day.dart';
import 'package:metamall/features/home/screens/widgets/top_categories.dart';
import 'package:metamall/features/search/screens/search_screen.dart';
import 'package:metamall/models/user.dart';
import 'package:metamall/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<UserProvider>(context).user;

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                color: GlobalVariables.backgroundColor,
              ),
            ),
            title: const AddressBox(),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            height: 42,
                            margin: const EdgeInsets.only(left: 15),
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
                                  fillColor:
                                      GlobalVariables.cardBackgroundColor,
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
                                    borderSide:
                                        BorderSide(color: Colors.black38),
                                  ),
                                  hintText: 'Search your desire',
                                  hintStyle: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Hello ${user.name},',
                      style: TextStyle(fontSize: 28),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const CarouselImage(),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      'Categories',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const TopCategories(),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Trending',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    const DealOfDay(),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
