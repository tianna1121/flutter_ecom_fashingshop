import 'package:flutter/material.dart';

import 'package:carousel_pro/carousel_pro.dart';

import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Widget image_carousel = new Container(
      height: 200.0,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('assets/images/w3.jpeg'),
          AssetImage('assets/images/c1.jpg'),
          AssetImage('assets/images/m1.jpeg'),
          AssetImage('assets/images/w4.jpeg'),
          AssetImage('assets/images/m2.jpg'),
        ],
        autoplay: false,
        dotSize: 4.0,
        indicatorBgPadding: 2.0,
        animationCurve: Curves.fastLinearToSlowEaseIn,
        animationDuration: Duration(milliseconds: 1000),
      ),
    );

    return Scaffold(
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: Colors.red,
          title: Text('ShopApp'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              // * Header of Drawer
              UserAccountsDrawerHeader(
                accountName: Text('Santos Enoque'),
                accountEmail: Text('santos@gmail.com'),
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                ),
                decoration: BoxDecoration(color: Colors.red),
              ),
              // * Body of Drawer
              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('HomePage'),
                  leading: Icon(Icons.home),
                ),
              ),

              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('My Account'),
                  leading: Icon(Icons.person),
                ),
              ),

              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('My Orders'),
                  leading: Icon(Icons.shopping_basket),
                ),
              ),

              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('Categories'),
                  leading: Icon(Icons.dashboard),
                ),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('Favorite'),
                  leading: Icon(Icons.favorite),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('Settings'),
                  leading: Icon(
                    Icons.settings,
                    color: Colors.blue,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('About'),
                  leading: Icon(
                    Icons.help,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            image_carousel,
          ],
        ));
  }
}
