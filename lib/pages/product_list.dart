import 'package:flutter/material.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/pages/product_edit.dart';
import 'package:flutter_app/scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductListPage extends StatefulWidget{
  final MainModel _model;

  ProductListPage(this._model);

  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }
}

class _ProductListState extends State<ProductListPage>{
  @override
  void initState() {
    widget._model.fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext ctx, Widget w, MainModel model) {
      return Container(
        padding: EdgeInsets.all(10.0),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int idx) {
            final Product currentProduct = model.products[idx];

            return Container(
                padding: EdgeInsets.all(5.0),
                child: Dismissible(
                    onDismissed: (DismissDirection dir) {
                      if (dir == DismissDirection.endToStart ||
                          dir == DismissDirection.startToEnd) {
                        model.removeProduct();
                      }
                    },
                    background: Container(
                      color: Colors.red,
                      child: Icon(Icons.delete),
                    ),
                    key: Key(currentProduct.title),
                    child: Column(children: <Widget>[
                      _buildListTile(context, model, idx),
                      Divider(),
                    ])));
          },
          itemCount: model.products.length,
        ),
      );
    });
  }

  ListTile _buildListTile(BuildContext context, MainModel model, int idx) {
    final Product currentProduct = model.products[idx];

    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(currentProduct.image)),
      title: Text(currentProduct.title),
      subtitle: Text('\$${currentProduct.price.toString()}'),
      trailing: _buildEditButton(context, model, idx),
    );
  }

  Widget _buildEditButton(BuildContext context, MainModel model, int idx) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        model.selectProduct(model.products[idx].id);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return ProductEditPage();
        }));
      },
    );
  }
}
