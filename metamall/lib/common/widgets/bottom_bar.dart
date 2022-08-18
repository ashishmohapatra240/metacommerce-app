import 'package:metamall/constants/global_variables.dart';
import 'package:metamall/features/account/screens/account_screen.dart';
import 'package:metamall/features/cart/screens/cart_screen.dart';
import 'package:metamall/features/home/screens/home_screen.dart';
import 'package:metamall/features/metaverse/screens/metaverse.dart';
import 'package:metamall/provider/user_provider.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 36;
  double bottomBarBorderWidth = 1;

  List<Widget> pages = [
    const HomeScreen(),
    const CartScreen(),
    const AccountScreen(),
    const Metaverse(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userCartLen = context.watch<UserProvider>().user.cart.length;
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.secondaryColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: const Color.fromRGBO(46, 46, 46, 1),
        iconSize: 24,
        onTap: updatePage,
        items: [
          //Home
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/Home_Bottom.png",
              height: 24,
            ),
            label: '',
          ),

          //Cart
          BottomNavigationBarItem(
            icon: Badge(
              elevation: 0,
              badgeContent: Text(
                userCartLen.toString(),
              ),
              badgeColor: GlobalVariables.secondaryColor,
              child: Image.asset(
                "assets/images/Cart_Bottom_Bar.png",
                height: 24,
              ),
            ),
            label: '',
          ),
          //Account
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/Account_Bottom_Bar.png",
              height: 24,
            ),
            label: '',
          ),
          //Metaverse
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/Metaverse_Bottom_Bar.png",
              height: 24,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
