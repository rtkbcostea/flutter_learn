import 'package:flutter/material.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/scoped-models/main.dart';
import 'package:flutter_app/widgets/uielements/title_default.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductPage extends StatelessWidget {
  final int index;

  ProductPage(this.index);

  _showWarningDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure'),
            content: Text('cant undoe!'),
            actions: <Widget>[
              FlatButton(
                child: Text('CANCEL'),
                onPressed: () => Navigator.pop(context),
              ),
              FlatButton(
                child: Text('DELETE'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context, true);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return _buildScaffold(context, model);
    }), onWillPop: () {
      Navigator.pop(context, false);
      return Future.value(false);
    });
  }

  Scaffold _buildScaffold(BuildContext context, MainModel model) {
    final Product prod = model.products[index];

    return Scaffold(
      appBar: AppBar(
        title: Text(prod.title),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(prod.image),
            TitleDefault(prod.title),
            RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text('delete'),
                onPressed: () => _showWarningDialog(context)),
          ]),
    );
  }
}
