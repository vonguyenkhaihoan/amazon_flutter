import 'package:amazon_flutter/constains/global_variables.dart';
import 'package:amazon_flutter/features/admin/screen/analytics_screen.dart';
import 'package:amazon_flutter/features/admin/screen/order_screen.dart';
import 'package:amazon_flutter/features/admin/screen/post_screen.dart';
import 'package:flutter/material.dart';

class AdminScreem extends StatefulWidget {
  const AdminScreem({super.key});

  @override
  State<AdminScreem> createState() => _AdminScreemState();
}

class _AdminScreemState extends State<AdminScreem> {
  //bien trang
  int _page = 0;
  double bottomBarWidget = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const PostScren(),
    const AnalyticsScreen(),

    const OrderScreen(),
  ];

  void updatepage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //AppBar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/amazon_in.png',
                  width: 120,
                  height: 45,
                  color: Colors.black,
                ),
              ),
              Container(
                child: Text(
                  'Admin',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),

      //Navgation
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatepage,
        items: [
          //Post Page
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidget,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.home_outlined,
              ),
            ),
            label: '',
          ),

          //ANALUTICS PAGE
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidget,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(Icons.analytics_outlined),
            ),
            label: '',
          ),

          //CART PAGE
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidget,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 2
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.all_inbox_outlined,
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
