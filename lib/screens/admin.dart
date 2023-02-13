//// ignore_for_file: deprecated_member_use, duplicate_ignore, prefer_final_fields, avoid_print

// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/customer.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:flutter_application_1/screens/inactive_products.dart';
import 'package:flutter_application_1/screens/orderrr.dart';
import 'package:flutter_application_1/screens/package_list.dart';
import 'package:flutter_application_1/screens/product_list.dart';
import 'package:flutter_application_1/screens/reported_orders.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../auth/change_password_page.dart';
import '../auth/login_admin.dart';
import 'add_packages.dart';
import 'add_product.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  int currentIndex = 0;

  List<Widget> _screens() {
    return [
      const HomeHeader(),
      const Orders(),
      const ProductList(),
      const InactiveProducts(),
    ];
  }

  MaterialColor active = Colors.deepPurple;
  MaterialColor notActive = Colors.grey;



  @override
  void initState() {
    // _getData();
    super.initState();
  }

  List<PersistentBottomNavBarItem> NavBarItems() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          title: 'Home',
          activeColorPrimary: Colors.deepPurple,
          inactiveColorPrimary: Colors.deepPurple[200]),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.shopping_bag_outlined),
          title: 'Orders',
          activeColorPrimary: Colors.orange,
          inactiveColorPrimary: Colors.deepPurple[200]),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.list),
          title: 'Products',
          activeColorPrimary: Colors.teal,
          inactiveColorPrimary: Colors.deepPurple[200]),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.local_activity_rounded),
          title: 'Inactive',
          activeColorPrimary: Colors.red,
          inactiveColorPrimary: Colors.deepPurple[200]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        // backgroundColor: Colors.grey.shade100,
        context,
        items: NavBarItems(),
        screens: _screens(),
        confineInSafeArea: true,
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style3,
      ),
     
    );
  }
}
