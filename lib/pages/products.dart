import 'package:flutter/material.dart';
import 'package:flutter_app/scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_app/widgets/products/products.dart';

class ProductsPage extends StatefulWidget {
  final MainModel model;

  ProductsPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _ProductPageState();
  }
}

class _ProductPageState extends State<ProductsPage> {
  @override
  void initState() {
    widget.model.fetchProducts();
    super.initState();
  }

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
              icon:
                  Icon(p.showOnlyFavs ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                p.toggleDisplayFavs();
              },
            );
          }),
        ],
      ),
      body: _buildProductList(),
    );
  }

  Widget _buildProductList() {
    return new ScopedModelDescendant(
        builder: (BuildContext ctx, Widget child, MainModel model) {
      Widget content = Center(child: new Text('no items'));
      if (model.displayedProducts.length > 0 && !model.isLoading) {
        content = Products();
      } else if (model.isLoading) {
        content = Center(child: CircularProgressIndicator());
      }

      return RefreshIndicator(
          child: content,
          onRefresh: model.fetchProducts,
      );
    });
  }
}
