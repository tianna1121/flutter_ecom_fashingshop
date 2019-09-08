import 'package:flutter/material.dart';

class CartProducts extends StatefulWidget {
  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  var Products_on_the_cart = [
    {
      "name": "Blazer",
      "picture": "assets/images/products/blazer1.jpeg",
      "price": 85,
      "size": "M",
      "Color": "Black",
      "Quantity": 1,
    },
    {
      "name": "Shoes",
      "picture": "assets/images/products/hills1.jpeg",
      "price": 50,
      "size": "7",
      "Color": "Red",
      "Quantity": 1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Products_on_the_cart.length,
      itemBuilder: (context, index) {
        return SingleCartProduct(
          cart_prod_name: Products_on_the_cart[index]["name"],
          cart_prod_color: Products_on_the_cart[index]["Color"],
          cart_prod_qty: Products_on_the_cart[index]["Quantity"],
          cart_prod_price: Products_on_the_cart[index]["price"],
          cart_prod_size: Products_on_the_cart[index]["size"],
          cart_prod_picture: Products_on_the_cart[index]["picture"],
        );
      },
    );
  }
}

class SingleCartProduct extends StatelessWidget {
  final cart_prod_name;
  final cart_prod_picture;
  final cart_prod_price;
  final cart_prod_size;
  final cart_prod_color;
  final cart_prod_qty;

  const SingleCartProduct({
    Key key,
    this.cart_prod_name,
    this.cart_prod_picture,
    this.cart_prod_price,
    this.cart_prod_size,
    this.cart_prod_color,
    this.cart_prod_qty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(
          cart_prod_picture,
          // width: 80.0,
          // height: 80.0,
        ),
        title: Text(cart_prod_name),
        subtitle: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text("Size:"),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    cart_prod_size,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 4.0, 4.0, 8.0),
                  child: Text('Color:'),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    cart_prod_color,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                '\$${cart_prod_price}',
                style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ),
          ],
        ),
        trailing: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_drop_up),
              onPressed: () {},
            ),
            Text('${cart_prod_qty}'),
            IconButton(
              icon: Icon(Icons.arrow_drop_down),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
