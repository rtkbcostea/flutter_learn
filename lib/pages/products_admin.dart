import 'package:flutter/material.dart';
import 'package:flutter_app/pages/product_edit.dart';
import 'package:flutter_app/pages/product_drawer.dart';
import 'package:flutter_app/pages/product_list.dart';
import 'package:flutter_app/scoped-models/main.dart';

class ProductsAdminPage extends StatelessWidget {
  final MainModel _model;

  ProductsAdminPage(this._model);

  @override
  Widget build(BuildContext context) {
    return
      DefaultTabController(
        length: 2,
        child:
            Scaffold(
              drawer: ProductMenu(),
              appBar: AppBar(
                title: Text('manage products'),
                bottom: TabBar(tabs: <Widget> [
                  Tab(text: 'Create Products', icon: Icon(Icons.create)),
                  Tab(text: 'My Products', icon: Icon(Icons.list)),
                ]),
              ),
              body: TabBarView(children: <Widget> [
                ProductEditPage(),
                ProductListPage(_model),
              ]
              ),
            ),
          );
    }
}