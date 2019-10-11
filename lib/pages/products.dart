import 'package:flutter/material.dart';
import 'package:flutter_app/scoped-models/main.dart';
import 'package:flutter_app/widgets/products/products.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductsPage extends StatelessWidget {
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
          ScopedModelDescendant<MainModel>(
              builder: (BuildContext ctx, Widget child, MainModel p) {
            return IconButton(
              icon: Icon(p.showOnlyFavs ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                p.toggleDisplayFavs();
              },
            );
          }),
        ],
      ),
      body: Products(),
    );
  }
}
