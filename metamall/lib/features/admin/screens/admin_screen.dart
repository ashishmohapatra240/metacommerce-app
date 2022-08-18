import 'package:metamall/features/admin/screens/analytics_screen.dart';
import 'package:metamall/features/admin/screens/orders_screen.dart';
import 'package:metamall/features/admin/screens/posts_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';

class AdminScreen extends StatefulWidget {
  static const String routeName = '/admin-screen';

  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;

  List<Widget> pages = [
    const PostsScreen(),
    const AnalyticsScreen(),
    const OrdersScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.secondaryColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.cardBackgroundColor,
        iconSize: 24,
        onTap: updatePage,
        items: [
          //Posts
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                  ),
                ),
              ),
              child: Image.asset(
                "assets/images/Admin_Home.png",
                height: 24,
              ),
            ),
            label: '',
          ),
          //Anatics
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                  ),
                ),
              ),
              child: Image.asset(
                "assets/images/Admin_Analytics.png",
                height: 24,
              ),
            ),
            label: '',
          ),
          //Orders
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 2
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                  ),
                ),
              ),
              child: Image.asset(
                "assets/images/Admin_Order.png",
                height: 24,
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
