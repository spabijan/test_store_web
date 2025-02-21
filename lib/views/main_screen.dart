import 'package:flutter/cupertino.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import "package:flutter/material.dart";
import 'package:test_store_web/views/side_bar_screens/banner_screen.dart';
import 'package:test_store_web/views/side_bar_screens/buyers_screen.dart';
import 'package:test_store_web/views/side_bar_screens/categories_screen.dart';
import 'package:test_store_web/views/side_bar_screens/orders_screen.dart';
import 'package:test_store_web/views/side_bar_screens/products_screen.dart';
import 'package:test_store_web/views/side_bar_screens/vendors_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectedScreen = VendorsScreen();

  void _screenSelector(item) {
    Widget newScreen = switch (item.route) {
      BuyersScreen.routeName => BuyersScreen(),
      VendorsScreen.routeName => VendorsScreen(),
      OrdersScreen.routeName => OrdersScreen(),
      CategoriesScreen.routeName => CategoriesScreen(),
      BannerScreen.routeName => BannerScreen(),
      ProductsScreen.routeName => ProductsScreen(),
      _ => throw UnimplementedError()
    };

    setState(() => _selectedScreen = newScreen);
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Management'),
      ),
      body: _selectedScreen,
      sideBar: SideBar(
        header: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.black),
          child: Center(
              child: Text('Admin console CMS',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.7))),
        ),
        items: [
          AdminMenuItem(
              title: "Vendors",
              route: VendorsScreen.routeName,
              icon: CupertinoIcons.person_3),
          AdminMenuItem(
              title: "Buyers",
              route: BuyersScreen.routeName,
              icon: CupertinoIcons.person),
          AdminMenuItem(
              title: "Orders",
              route: OrdersScreen.routeName,
              icon: CupertinoIcons.shopping_cart),
          AdminMenuItem(
              title: "Categories",
              route: CategoriesScreen.routeName,
              icon: Icons.category),
          AdminMenuItem(
              title: "Upload Banner",
              route: BannerScreen.routeName,
              icon: Icons.upload),
          AdminMenuItem(
              title: "Products",
              route: ProductsScreen.routeName,
              icon: Icons.shopping_cart),
        ],
        selectedRoute: VendorsScreen.routeName,
        onSelected: (item) => _screenSelector(item),
      ),
    );
  }
}
