import 'package:flutter/material.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_app/widgets/products/product_card.dart';

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return _buildProductList(model.displayedProducts);
    });
  }

  Widget _buildProductList(List<Product> products) {
     return products.length > 0
        ? ListView.builder(
            itemBuilder: (BuildContext ctx, int idx) =>
                ProductCard(products[idx], idx),
            itemCount: products.length,
          )
        : Center(child: Text('No items'));
  }
}
