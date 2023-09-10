import 'package:flutter/material.dart';

import '../bag/bag_screen.dart';
import '../items/items_screen.dart';
import '../shop/shop_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color myGreenColor = const Color(0xFF008754);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: myGreenColor,
        appBar: AppBar(
          title: Image.asset("assets/icons/zappy_logo.png"),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(
                Icons.notifications_outlined,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
            ),
          ],
          elevation: 0,
          backgroundColor: myGreenColor,
        ),
        body: Column(
          children: [
            ColoredBox(
              color: myGreenColor,
              child: TabBar(
                indicatorWeight: 3,
                indicatorColor: Colors.white,
                dividerColor: myGreenColor,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shop),
                        SizedBox(width: 8.0),
                        Text("Shope"),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shop),
                        SizedBox(width: 8.0),
                        Text("items"),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shop),
                        SizedBox(width: 8.0),
                        Text("Bag"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(children: [
                ShopScreen(),
                ItemsScreen(),
                BagScreen(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
