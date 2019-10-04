import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/products/products.dart';

class ProductsPage extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  ProductsPage(this.products);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              title: Text('choose'),
              automaticallyImplyLeading: false,
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('managed products'),
              onTap: () {
                Navigator.pushReplacementNamed(context, 'admin');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('easy list'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: (){},
          ) ,
        ],
      ),
      body: Products(products),
    );
  }
}
