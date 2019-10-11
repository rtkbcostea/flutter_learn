import 'package:flutter/material.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/scoped-models/main.dart';
import 'package:flutter_app/widgets/products/price_tag.dart';
import 'package:flutter_app/widgets/uielements/title_default.dart';
import 'package:scoped_model/scoped_model.dart';

import 'address_tag.dart';

class ProductCard extends StatelessWidget {
  final Product  _product;
  final int _prodIdx;
  ProductCard(this._product, this._prodIdx);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget> [
          Image.asset(_product.image),
          Container(
            padding: EdgeInsets.only(top: 1.5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TitleDefault(_product.title),
                  SizedBox(width: 8.0),
                  PriceTag((_product.price).toString()),
                ]),
          ),
          AddressTag('somewhere, somecity'),
          Text(_product.userEmail),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.info),
                  onPressed: () =>
                      Navigator.pushNamed<bool>(context, '/product/'+_prodIdx.toString())
              ),
              ScopedModelDescendant<MainModel>(builder:
              (BuildContext ctx, Widget w, MainModel p) {
                return IconButton(
                    icon: Icon(p.products[_prodIdx].isFavourite ? Icons.favorite : Icons.favorite_border),
                    color: Colors.red,
                    onPressed: () {
                      p.selectProduct(_prodIdx);
                      p.toggleProductFavouriteStatus();
                    }
               );}),
            ],),
        ],),
    );
  }
}